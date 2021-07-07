/*
* Copyright (C) 2018-2019 Shubham Arora <shubhamarora@protonmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
* Authored by: Shubham Arora <shubhamarora@protonmail.com>
*/

public class Gitignore.Views.AppView : Gtk.Grid {

    public Gtk.Grid tag_grid;
    private Gtk.Stack stack;

    private Gitignore.Views.GitignoreView gitignore_view;

    private Gitignore.Widgets.Button generate_gitignore_button;
    private Gtk.Button copy_button;
    private Gtk.Button save_button;
    private Gtk.Button bookmark_button;

    private Granite.Widgets.Toast copy_toast;
    private Granite.Widgets.Toast file_created_toast;

    private Gitignore.Services.Database db;

    public signal void tags_changed ();

    public AppView (Gdk.Display display, Gtk.ApplicationWindow window) {
        var icon = new Gtk.Image ();
        icon.gicon = new ThemedIcon ("starred");
        icon.pixel_size = 24;

        db = new Gitignore.Services.Database ();

        generate_gitignore_button.clicked.connect (() => {
            stack.visible_child_name = "gitignore_view_stack";
            gitignore_view.load_data ();
            toggle_buttons ();
        });

        bookmark_button.clicked.connect (() => {
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");
            string[] data = settings.get_strv ("selected-langs");

            var bookmark_dialog = new Widgets.BookmarkDialog (window, data, db);
            bookmark_dialog.show_all ();

            bookmark_dialog.bookmark_added.connect (() => {
                bookmark_button.set_image (icon);
            });
        });

        copy_button.clicked.connect (() => {
            Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);
            clipboard.set_text (gitignore_view.source_buffer.text, -1);
            copy_toast.valign = Gtk.Align.END;
            copy_toast.send_notification ();
        });

        save_button.clicked.connect (() => {
            var filech = Utils.new_file_chooser_dialog ( _("Save File"), null);
            filech.do_overwrite_confirmation = true;
            filech.set_current_name (".gitignore");

            if (filech.run () == Gtk.ResponseType.ACCEPT) {
                try {
                    var data_file = File.new_for_uri (filech.get_current_folder_uri () +"/.gitignore");

                    var file_stream = data_file.create (FileCreateFlags.NONE);

                    if (data_file.query_exists ()) {
                        debug ("File successfully created.");
                    }

                    var data_stream = new DataOutputStream (file_stream);
                    data_stream.put_string (gitignore_view.source_buffer.text);

                    file_created_toast.valign = Gtk.Align.END;
                    file_created_toast.send_notification ();
                } catch (Error e) {
                    debug ("Error: " + e.message);
                }
            }

            filech.destroy ();
        });

        update_tags ();
    }

    construct {

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

        var content_box =new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        content_box.margin = 10;
        content_box.spacing = 5;
        content_box.valign = Gtk.Align.CENTER;

        tag_grid = new Gtk.Grid ();

        save_button = new Gtk.Button.from_icon_name ("document-save-as", Gtk.IconSize.LARGE_TOOLBAR);
        save_button.set_tooltip_text (_("Save as file"));
        save_button.get_style_context ().add_class ("flat");

        bookmark_button = new Gtk.Button.from_icon_name ("non-starred", Gtk.IconSize.LARGE_TOOLBAR);
        bookmark_button.set_tooltip_text (_("Bookmark selected languages"));
        bookmark_button.get_style_context ().add_class ("flat");

        generate_gitignore_button = new Gitignore.Widgets.Button (_("Generate .gitignore"), "media-playback-start");
        generate_gitignore_button.set_tooltip_text (_("Generate .gitignore from selected languages"));
        generate_gitignore_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        generate_gitignore_button.get_style_context ().add_class ("flat");

       content_box.pack_start (tag_grid, false, false, 0);
        content_box.pack_end (generate_gitignore_button, false, false, 0);
        content_box.pack_end (bookmark_button, false, false, 0);
        content_box.pack_end (copy_button, false, false, 0);
        content_box.pack_end (save_button, false, false, 0);

        var welcome_view = new Gitignore.Views.WelcomeView ();
        gitignore_view = new Gitignore.Views.GitignoreView ();

        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        stack.add_titled ( welcome_view, "welcome_view_stack", _("Welcome View"));
        stack.add_titled ( gitignore_view, "gitignore_view_stack", _("Gitignore View"));
        stack.visible_child_name = "welcome_view_stack";
        stack.show_all ();

        copy_toast = new Granite.Widgets.Toast (_("Copied content to clipboard"));
        file_created_toast = new Granite.Widgets.Toast (_("File successfully created."));

        box.pack_start (content_box, false, true, 0);
        box.pack_start (stack, false, true, 0);
        attach (box, 0, 0, 1, 1);
        attach (copy_toast, 0, 0, 1, 1);
        attach (file_created_toast, 0, 0, 1, 1);
    }

    public void update_tags () {
        var settings = new GLib.Settings ("com.github.arshubham.gitignore");

        string[] data = settings.get_strv ("selected-langs");

        if (data != null && data.length > 0) {
            for (int i = 0; i < data.length + 1; i++) {
                tag_grid.remove_column (i);
            }
        }

        var children = tag_grid.get_children ();
        foreach (Gtk.Widget element in children) {
            tag_grid.remove (element);
        }

        if (data != null && data.length > 0) {
            for (int i = 0; i < data.length; i++) {
                var tag = new Gitignore.Widgets.Tag (data[i]);
                tag_grid.attach (tag, i, 0);
                tag.tag_deleted.connect (() => {
                    update_tags ();
                });
            }
        }

        tag_grid.show_all ();
        toggle_buttons ();
        gitignore_view.update_theme ();
    }

    public void toggle_buttons () {
        var settings = new GLib.Settings ("com.github.arshubham.gitignore");

        string[] data = settings.get_strv ("selected-langs");

        if (stack.visible_child_name == "welcome_view_stack") {
            save_button.set_sensitive (false);
            copy_button.set_sensitive (false);
            save_button.set_opacity (0);
            copy_button.set_opacity (0);

            if (data != null && data.length > 0) {
                generate_gitignore_button.set_sensitive (true);
            } else {
                generate_gitignore_button.set_sensitive (false);
            }

        } else if (stack.visible_child_name == "gitignore_view_stack") {
            copy_button.set_sensitive (true);
            save_button.set_sensitive (true);
            save_button.set_opacity (1);
            copy_button.set_opacity (1);

            if (data != null && data.length > 0) {
                generate_gitignore_button.set_sensitive (true);
            } else {
                generate_gitignore_button.set_sensitive (false);
            }
        }
    }
}