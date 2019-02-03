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

namespace App.Views {

    public class AppView : Gtk.Grid {

        private Gtk.Grid tag_grid;
        private Gtk.Stack stack;
        private App.Widgets.Button generate_gitignore_button;
        private GitignoreView gitignore_view;

        public signal void tags_changed ();

        public AppView () {
            stack.show_all ();
            stack.visible_child_name = "welcome_view_stack";

            generate_gitignore_button.clicked.connect (() => {
                stack.visible_child_name = "gitignore_view_stack";
                gitignore_view.load_data ();
            });

            
        }

        construct {
            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var content_box =new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            content_box.margin = 10;
            content_box.spacing = 5;
            content_box.valign = Gtk.Align.CENTER;

            tag_grid = new Gtk.Grid ();

            update_tags ();

            generate_gitignore_button =  new App.Widgets.Button ("Generate .gitignore", "media-playback-start");
            generate_gitignore_button.set_tooltip_text ("Generate .gitignore from selected languages"); 
            generate_gitignore_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            content_box.pack_start (tag_grid, false, false, 0);
            content_box.pack_end (generate_gitignore_button, false, false, 0);

            var welcome_view = new WelcomeView ();
            gitignore_view = new GitignoreView ();
            stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
            stack.add_titled ( welcome_view, "welcome_view_stack", _("Welcome View"));
            stack.add_titled ( gitignore_view, "gitignore_view_stack", _("Gitignore View"));
            
            
            
            box.pack_start (content_box, false, true, 0);
            box.pack_start (stack, false, true, 0);
            attach (box, 0, 0, 1, 1);
        }

        public void update_tags () {
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");
            string[] data = settings.get_strv ("selected-langs");
            for (int i = 0; i < data.length + 1; i++) {
                tag_grid.remove_column (i);
            }
            var children = tag_grid.get_children ();
            foreach (Gtk.Widget element in children) {
                tag_grid.remove (element);
            }
            

            for (int i = 0; i < data.length; i++) {
                var tag = new App.Widgets.Tag (data[i]);
                tag_grid.attach (tag, i, 0);
            }


            tag_grid.show_all ();
        }
    }
}
