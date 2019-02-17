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

namespace App.Widgets {
    public class BookmarksPopover : Gtk.Popover {

        private Gtk.Stack stack;
        public Gtk.ListBox listbox;

        public BookmarksPopover (Gtk.Widget relative, Gtk.ApplicationWindow window) {
            Object (
                modal: true,
                position: Gtk.PositionType.BOTTOM,
                relative_to: relative
            );

            set_size_request(300, 400);
        }

        construct {
            stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;

            stack.add_titled ( bookmark_list_grid (), "bookmark_list_stack", _("Bookmark List"));
            stack.add_titled ( no_bookmarks_grid (), "no_bookmarks_stack", _("New User"));

            stack.visible_child_name = "bookmark_list_stack";
            create_bookmark_list ();

            var content_grid = new Gtk.Grid ();
            content_grid.attach (stack, 0, 0, 1, 1);
            add (content_grid);
        }

        private Gtk.Widget no_bookmarks_grid () {
            var grid = new Gtk.Grid ();
            grid.orientation = Gtk.Orientation.VERTICAL;
            grid.row_spacing = 4;
            grid.halign = Gtk.Align.CENTER;
            grid.valign = Gtk.Align.CENTER;
            grid.margin = 12;
            grid.column_homogeneous = true;

            var label = new Gtk.Label (_("No Bookmarks Available"));
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
            label.wrap = true;
            label.wrap_mode = Pango.WrapMode.WORD;
            label.expand = true;
            label.valign = Gtk.Align.CENTER;
            label.halign = Gtk.Align.CENTER;

            grid.attach (label, 0, 0);

            return grid;
        }

        private Gtk.Widget bookmark_list_grid () {
            var grid = new Gtk.Grid ();
            grid.orientation = Gtk.Orientation.VERTICAL;
            grid.row_spacing = 4;
            grid.margin = 12;
            grid.column_homogeneous = true;
            grid.expand = true;

            listbox = new Gtk.ListBox ();
            listbox.activate_on_single_click = true;
            listbox.selection_mode = Gtk.SelectionMode.SINGLE;
            listbox.expand = true;

            var scrolled_window = new Gtk.ScrolledWindow (null, null);
            scrolled_window.expand = true;
            scrolled_window.add (listbox);

            grid.attach (scrolled_window, 0, 0);

            return grid;
        }

            private void create_bookmark_list () {

                for (int i = 0; i < 10; i++) {
                    var row = new Widgets.BookmarkItem (new Models.Bookmark ("Bookmarks" + i.to_string (), "asda"));
                    listbox.add (row);
                }
     
            }

    }
}
