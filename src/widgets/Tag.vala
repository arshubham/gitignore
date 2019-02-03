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
        
        public Tag (string language) {
            Object (
                margin_start: 8,
                valign: Gtk.Align.CENTER
            );
            label.set_text (language);

            attach (box, 0, 0);
        }

        construct {
            box =  new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            label = new Gtk.Label ("");
            label.margin_start = 15;

            icon = new Gtk.Image ();
            icon.gicon = new ThemedIcon ("window-close");
            icon.pixel_size = 16;
            icon.margin_end = 7;
            icon.margin_top = 2;
            icon.margin_start = 10;

            box.pack_start (label);
            box.pack_end (icon);
            get_style_context ().add_class ("tag");
        }
    }
}   
