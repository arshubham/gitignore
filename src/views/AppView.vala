/*
* Copyright (C) 2018  Shubham Arora <shubhamarora@protonmail.com>
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
*/

using App.Configs;
using App.Widgets;

namespace App.Views {

    /**
     * The {@code AppView} class.
     *
     * @since 1.0.0
     */
    public class AppView : Gtk.Grid {

        /**
         * Constructs a new {@code AppView} object.
         */

            private Gtk.ScrolledWindow terminal_output;
            private Gtk.SourceView source_view;
            public Gtk.SourceBuffer source_buffer;
            public string language;
            private Gtk.Button copy;
            private Gtk.Button reset;
            private Granite.Widgets.Toast notification;
            Gee.HashSet<string> selected_langs;
            private App.Widgets.Button generate;
            private Gee.ArrayList<App.Widgets.Tag>  tag_buttons;
            Gtk.Label t1;
            Gtk.Label t2;
            string slgs = "";
            Granite.Widgets.Toast select_lang_toast;
        construct {
            select_lang_toast = new Granite.Widgets.Toast (_("Select at least one language to generate .gitignore!"));
            Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            Gtk.Box content =new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            content.margin = 10;
            content.spacing = 5;
            tag_buttons = new Gee.ArrayList<App.Widgets.Tag> ();
            add_tags ();
            t2 = new Gtk.Label ("");

            generate =  new App.Widgets.Button ("Generate .gitignore", "media-playback-start");
            generate.set_tooltip_text ("Generate .gitignore from selected languages");

            //TODO: V2
           //save = new Gtk.Button.from_icon_name ("document-save", Gtk.IconSize.BUTTON);
            //save.set_tooltip_text ("Save generated .gitignore as file");

            copy = new Gtk.Button.from_icon_name ("edit-copy", Gtk.IconSize.BUTTON);
            copy.set_tooltip_text ("Copy generated gitignore");

            reset = new Gtk.Button.from_icon_name ("process-stop", Gtk.IconSize.BUTTON);
            reset.set_tooltip_text ("Reset selected languages");
            var tag = new App.Widgets.Tag ("Java");

            var menu_grid = new Gtk.Grid ();

            content.pack_start (t1, false, false, 0);
            //content.pack_start (t2, false, false, 0);
             for (int i = 0; i < tag_buttons.size; i++) {
                menu_grid.attach (tag_buttons[i], i, 1, 1, 1);
            }
            content.pack_start (menu_grid, false, false, 0);
            content.pack_end (generate, false, false, 0);

            content.pack_end (copy, false, false, 0);
            //content.pack_end (save, false, false, 0);

            content.pack_end (reset, false, false, 0);

            source_buffer = new Gtk.SourceBuffer (null);
            source_buffer.highlight_syntax = true;
            source_buffer.language = Gtk.SourceLanguageManager.get_default ().get_language ("text");




            source_view = new Gtk.SourceView ();


            source_buffer.text = "\n\nSelect a Language from the dropdown and press enter.\nThe selected languages will appear in shown. Press Generate .gitignore to fetch .gitignore file.";





            source_view.buffer = source_buffer;
            source_view.editable = false;
            source_view.monospace = true;
            source_view.show_line_numbers = true;
            terminal_output = new Gtk.ScrolledWindow (null, null);
            terminal_output.hscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            terminal_output.expand = true;
            terminal_output.add (source_view);
            box.pack_start (content, false, true, 0);
            box.pack_start (terminal_output, false, true, 0);
            notification = new Granite.Widgets.Toast (_("Copied to clipboard"));
            attach (notification, 0, 0, 1, 1);
            attach (box, 0, 0, 1, 1);
            attach (select_lang_toast, 0, 0, 1, 1);
        }

        public AppView (Gdk.Display display, Gee.HashSet<string> selected_langs) {
            Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);

            copy.clicked.connect (() => {
                clipboard.set_text (source_buffer.text, -1);

                notification.valign = Gtk.Align.END;
                notification.send_notification ();
            });

            reset.clicked.connect (() => {
                    slgs = "";
                    this.selected_langs.clear ();
                    t2.set_text ("");
            });

            generate.clicked.connect (() => {
            if (slgs.length == 0) {
                select_lang_toast.send_notification ();
            }
            else {
                 try {
                    int exitCode;
                    string std_out;
                    string cmd = "curl -L -s https://www.gitignore.io/api/"+slgs.slice (0, slgs.length-1);
                    debug (cmd);
                    Process.spawn_command_line_sync(cmd, out std_out, null, out exitCode);
                    stdout.printf (std_out);


                    source_buffer.text = std_out;
                    source_view.buffer = source_buffer;
                    }   catch (Error e) {
                        debug (e.message);
                    }
                    }
            });


                this.selected_langs = selected_langs;
        }

        public void dark_theme () {
                source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-dark");

        }

        public void light_theme () {

            source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");

        }

        public void update_langs (Gee.HashSet<string> sl2) {
            this.selected_langs = sl2;
            add_tags();
        }

        public void update_tags () {
            slgs = "";
            foreach (string l in selected_langs) {
                slgs = slgs+l+",";
            }
            debug ("selected langs: " + slgs);

            string[] lgs = slgs.slice (0, slgs.length-1).split (",");

            foreach ( unowned string l in lgs) {
                  var tag = new Tag (l);
                  tag_buttons.add (tag);
                  debug ("button set for"+ l);
            }

        }
        public void add_tags () {
             t1 = new Gtk.Label ("Selected Languages:");
             update_tags ();
        }
    }
}
