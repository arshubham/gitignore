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

public class Gitignore.Widgets.BookmarkDialog : Gtk.Dialog {

    private Gtk.Grid grid;
    private Gtk.Entry bookmark_name_entry;
    private Gtk.FlowBox tags_flow_box;

    private Gtk.Revealer bookmark_name_entry_revealer;

    Gitignore.Services.Database db;
    string[] languages;

    public signal void bookmark_added ();

    public BookmarkDialog (Gtk.ApplicationWindow window, string[] languages, Gitignore.Services.Database db) {
        Object (
            title: _("Bookmark Dialog"),
            window_position: Gtk.WindowPosition.CENTER,
            resizable: true,
            deletable: false,
            modal: true,
            skip_taskbar_hint: true,
            transient_for: window

        );

        foreach (var language in languages) {
            var tag = new Gitignore.Widgets.Tag (language);
            tag.hide_close_button ();
            tags_flow_box.add (tag);
        }

        this.db = db;
        this.languages = languages;

        bookmark_name_entry.button_release_event.connect_after (()=>{
            bookmark_name_entry_revealer.set_reveal_child (false);
            return true;
        });

        set_default_size (400, 150);
        set_keep_above (true);
        get_content_area ().add (grid);
    }

    construct {
        var heading = new Gtk.Label (_("Save a new Bookmark"));
        heading.get_style_context ().add_class ("primary");
        heading.valign = Gtk.Align.END;
        heading.xalign = 0;

        bookmark_name_entry = new Gtk.Entry ();
        bookmark_name_entry.hexpand = true;
        bookmark_name_entry.primary_icon_name = "bookmark-new";
        bookmark_name_entry.primary_icon_tooltip_text = "Bookmark Name";
        bookmark_name_entry.activates_default = true;

        var bookmark_name_entry_label = new Gtk.Label (_("Bookmark name cannot be empty."));
        bookmark_name_entry_label.halign = Gtk.Align.START;
        bookmark_name_entry_label.get_style_context ().add_class (Gtk.STYLE_CLASS_ERROR);

        bookmark_name_entry_revealer = new Gtk.Revealer ();
        bookmark_name_entry_revealer.add (bookmark_name_entry_label);


        tags_flow_box = new Gtk.FlowBox ();
        tags_flow_box.margin_top = 6;
        tags_flow_box.row_spacing = 6;
        tags_flow_box.selection_mode = Gtk.SelectionMode.NONE;
        tags_flow_box.homogeneous = false;

        grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.row_spacing = 6;
        grid.margin_start = grid.margin_end = 12;
        grid.attach (heading, 0, 0, 5, 1);
        grid.attach (bookmark_name_entry, 0, 1, 5, 1);
        grid.attach (bookmark_name_entry_revealer, 0, 2, 5, 1);
        grid.attach (tags_flow_box, 0, 3, 5, 1);

        var cancel_button = (Gtk.Button)add_button (_("Cancel"), Gtk.ResponseType.CANCEL);
        cancel_button.clicked.connect (() => {
            cancel ();
        });

        var add_bookmark_button = (Gtk.Button)add_button (_("Add Bookmark"), Gtk.ResponseType.APPLY);
        add_bookmark_button.get_style_context ().add_class ("suggested-action");
        add_bookmark_button.clicked.connect (add_bookmark);

        set_default (add_bookmark_button);

        close.connect (cancel);
    }

    private void add_bookmark () {
        debug ("Adding Bookmark");
        if (bookmark_name_entry.text == "") {
            debug ("Show Reveler");
            bookmark_name_entry_revealer.reveal_child = true;
            shake ();
        } else {
            debug ("Add Bookmark");
            string langs = "";
            for (int i = 0; i < languages.length; i++) {
                langs = langs + languages[i] + ",";
            }

            langs = langs.slice (0, langs.length-1);
            db.add_bookmark (new Models.Bookmark (bookmark_name_entry.text, langs));
            bookmark_added ();
            cancel ();
        }
    }

    public override void show () {
        base.show ();
    }

    private void cancel () {
        debug ("Bookmark Dialog cancelled");
        this.destroy ();
    }

    private void shake () {
        int x, y;
        get_position (out x, out y);

        for (int n = 0; n < 10; n++) {
            int diff = 15;
            if (n % 2 == 0) {
                diff = -15;
            }

            move (x + diff, y);

            while (Gtk.events_pending ()) {
                Gtk.main_iteration ();
            }

            Thread.usleep (10000);
        }

        move (x, y);
    }
}