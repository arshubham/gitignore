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

    public class WelcomeView : Gtk.Grid {
        public WelcomeView () {
            Object (
                halign: Gtk.Align.CENTER,
                hexpand: true,
                margin_bottom: 150,
                row_spacing: 10,
                valign: Gtk.Align.CENTER,
                vexpand: true
            );
        }

        construct {
            var image = new Gtk.Image.from_resource ("/com/github/arshubham/gitignore/images/128-com.github.arshubham.gitignore.svg");

            var title = new Gtk.Label (_("gitIgnore"));
            title.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

            var subtitle = new Gtk.Label (_(".gitignore reference for various languages"));

            var usage_instructions = _("Select a Language from the dropdown and press enter."
                       + "The selected languages will appear as tags. Press 'Generate .gitignore' "
                       + "to fetch .gitignore file. Internet connection is required to use gitIgnore");

            var copy = new Gtk.Label ("<b>%s</b>".printf (usage_instructions));
            copy.margin = 24;
            copy.max_width_chars = 70;
            copy.use_markup = true;
            copy.wrap = true;

            attach (image, 0, 0);
            attach (title, 0, 1);
            attach (subtitle, 0, 2);
            attach (copy, 0, 3);
            get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);
        }
    }
}
