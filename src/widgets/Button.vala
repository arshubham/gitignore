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

    public class Button : Gtk.Button {

        public Button (string text, string icon_name) {
            Object (

            );
            Gtk.Box box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            var label_btn = new Gtk.Label (text);

            var icon = new Gtk.Image ();
            icon.gicon = new ThemedIcon (icon_name);
            icon.pixel_size = 16; 

            box.add (icon);
            box.add (label_btn);
            add (box);
            margin_start = 8;
        }
    }
}   