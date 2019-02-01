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

    public class SearchEntry : Gtk.SearchEntry {

        public SearchEntry (App.Widgets.EntryCompletion entry_completion) {
            Object (
                hexpand: true,
                placeholder_text: "Select a Language from the dropdown and press enter.",
                valign: Gtk.Align.CENTER
            );
            set_completion (entry_completion);
            grab_focus_without_selecting ();
        }
    }
}