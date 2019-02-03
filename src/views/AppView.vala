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

        construct {
            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var content_box =new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            content_box.margin = 10;
            content_box.spacing = 5;

            var generate_gitignore_button =  new App.Widgets.Button ("Generate .gitignore", "media-playback-start");
            generate_gitignore_button.set_tooltip_text ("Generate .gitignore from selected languages");

            content_box.pack_end (generate_gitignore_button, false, false, 0);

            var alignment_grid = new Gtk.Grid ();
            alignment_grid.halign = Gtk.Align.CENTER;
            alignment_grid.hexpand = true;
            alignment_grid.margin_bottom = 200; // Roughly visually centered
            alignment_grid.orientation = Gtk.Orientation.VERTICAL;
            alignment_grid.valign = Gtk.Align.CENTER;
            alignment_grid.vexpand = true;

            var title = new Gtk.Label ("gitIgnore");
            title.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

            var subtitle = new Gtk.Label (_(".gitignore reference for various languages"));

            var usage_instructions = _("Select a Language from the dropdown and press enter. The selected languages will appear as tags. Press \"Generate .gitignore\" to fetch .gitignore file.");

            var copy = new Gtk.Label ("%s".printf (usage_instructions));
            copy.margin = 24;
            copy.max_width_chars = 70;
            copy.use_markup = true;
            copy.wrap = true;
            
            alignment_grid.add (title);
            alignment_grid.add (subtitle);
            alignment_grid.add (copy);
            alignment_grid.get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);

            box.pack_start (content_box, false, true, 0);
            box.pack_start (alignment_grid, false, true, 0);
            attach (box, 0, 0, 1, 1);
        }

    }
}
