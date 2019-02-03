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
    
    public class SourceView : Gtk.SourceView {
        public SourceView (Gtk.SourceBuffer source_buffer) {
            Object (
                buffer: source_buffer,
                editable: false,
                monospace: true,
                expand: true,
                show_line_numbers: false,
                left_margin: 6,
                right_margin: 6,
                pixels_above_lines: 3,
                pixels_below_lines: 3
            );
        }
    }
}