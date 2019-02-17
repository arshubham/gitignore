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
    public class BookmarkItem : Gtk.EventBox {

        private Gtk.Label bookmark_name_label;
        private Gtk.Label languages_label;

        public BookmarkItem (Models.Bookmark bookmark) {
            Object (
                can_focus: false,
                expand: true
            );

            bookmark_name_label.label = bookmark.bookmarkName;
            
            languages_label.label = bookmark.languages.replace (",", " ").strip ();
        }

        construct {
            var grid = new Gtk.Grid ();
            grid.margin_top = 8;
            grid.margin_bottom = 8;

            bookmark_name_label = new Gtk.Label ("");
            bookmark_name_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            bookmark_name_label.ellipsize = Pango.EllipsizeMode.END;
            bookmark_name_label.halign = Gtk.Align.START;
            bookmark_name_label.margin_start = 4;

            languages_label = new Gtk.Label ("");
            languages_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            languages_label.ellipsize = Pango.EllipsizeMode.END;
            languages_label.halign = Gtk.Align.START;

            var edit_button = new Gtk.Button.from_icon_name ("document-edit-symbolic",  Gtk.IconSize.MENU);
            edit_button.valign = Gtk.Align.CENTER;
            edit_button.halign = Gtk.Align.END;
            edit_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            set_focus_on_click (false);
            edit_button.tooltip_text = _("Edit Bookmark");

            //  edit_button.clicked.connect ( () => {
            //      edit_button_active (bookmar);
            //  });


            var delete_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.MENU);
            delete_button.valign = Gtk.Align.CENTER;
            delete_button.halign = Gtk.Align.END;
            delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            delete_button.tooltip_text = _("Delete Bookmark");

            //  delete_button.clicked.connect ( () => {
            //      debug ("Emitting signal delete_button_active");
            //      delete_button_active (user);

            //  });

            var action_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 3);
            action_box.expand = true;
            action_box.halign = Gtk.Align.END;
            action_box.visible = false;

            action_box.pack_start (edit_button, false, false, 3);
            action_box.pack_start (delete_button, false, false, 3);

            var action_revealer = new Gtk.Revealer ();
            action_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            action_revealer.add (action_box);
            action_revealer.transition_duration = 1000;
            action_revealer.show_all ();
            action_revealer.set_reveal_child (false);

            this.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);

            this.enter_notify_event.connect ( (event) => {
                action_revealer.set_reveal_child (true);
                action_box.visible = true;
                return false;

            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }

                action_revealer.set_reveal_child (false);
                action_box.visible = false;
                return false;

            });

            grid.column_spacing = 12;
            grid.attach (bookmark_name_label, 0, 0, 1, 1);
            grid.attach (languages_label, 0, 1, 1, 1);
            grid.attach (action_revealer, 1, 0, 2, 2);
            add (grid);
            show_all ();
        }


    }
}
