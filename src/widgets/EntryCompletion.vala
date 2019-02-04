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

    public class EntryCompletion : Gtk.EntryCompletion {

        public EntryCompletion () {
            Object (
                inline_selection: true,
                popup_single_match: false
            );

            var data = DataSet.DATA;

            var list_store = new Gtk.ListStore (1, typeof (string));
            set_model (list_store);
            set_text_column (0);

            Gtk.TreeIter iter;
            for (int i = 0; i < data.length ; i++) {
                list_store.append (out iter);
                list_store.set (iter, 0, data[i]);
            }
        }
    }
}