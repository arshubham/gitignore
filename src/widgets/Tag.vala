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

namespace App.Widgets {

    public class Tag : Gtk.Grid {

        private Gtk.Box box;
        private Gtk.Label label;
        private Gtk.Image icon;
        private Gtk.EventBox close_button;
        public signal void update_tags ();
        
        public Tag (string language) {
            Object (
                valign: Gtk.Align.CENTER,
                margin_start: 6,
                margin_end: 6
            );
            label.set_text (language);

            attach (box, 0, 0);
        }

        construct {
            box =  new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            label = new Gtk.Label ("");
            label.margin_end = 4;

            icon = new Gtk.Image ();
            icon.gicon = new ThemedIcon ("window-close");
            icon.margin_start = 4;
            icon.margin_end = 2;

            close_button = new Gtk.EventBox ();
            close_button.add (icon);
            close_button.visible_window = false;
            close_button.button_release_event.connect (on_button_released);

            box.pack_start (close_button);
            box.pack_end (label);
            get_style_context ().add_class ("tag");
        }

        private bool on_button_released (Gtk.Widget sender, Gdk.EventButton event) {
            debug ("Remove " + label.label);
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");

            string[] data = settings.get_strv ("selected-langs");
            GenericArray<string> array = new GenericArray<string> ();
            for (var i = 0; i < data.length; i++) {
                if (data[i] != label.label) {
                    array.add (data[i]);
                }
            }
            
            // FIXME: Crash
            settings.set_strv ("selected-langs", array.data);
            update_tags ();
            return true;
        }
    }
}   
