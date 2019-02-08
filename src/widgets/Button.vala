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

    public class Button : Gtk.Button {

        private new Gtk.Label label;
        private new Gtk.Image image;

        public Button (string text, string icon) {
            Object (
                margin_start: 8
            );

            label.set_text (text);
            image.gicon = new ThemedIcon (icon);
        }

        construct {
            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            label = new Gtk.Label ("");

            image = new Gtk.Image ();
            image.pixel_size = 16;
            image.margin_end = 4;

            box.add (image);
            box.add (label);

            add (box);
        }
    }
}