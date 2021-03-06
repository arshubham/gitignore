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

namespace Gitignore.Utils {

    public string? last_path = null;

    public Gtk.FileChooserNative new_file_chooser_dialog (string title, Gtk.Window? parent) {
        var all_files_filter = new Gtk.FileFilter ();
        all_files_filter.set_filter_name (_("All files"));
        all_files_filter.add_pattern ("*");

        var text_files_filter = new Gtk.FileFilter ();
        text_files_filter.set_filter_name (_("Text files"));
        text_files_filter.add_mime_type ("text/*");

        var filech = new Gtk.FileChooserNative (title, parent, Gtk.FileChooserAction.SAVE, "_Save", "_Cancel");
        filech.add_filter (all_files_filter);
        filech.add_filter (text_files_filter);
        filech.set_current_folder_uri (Utils.last_path ?? GLib.Environment.get_home_dir ());




        return filech;
    }
}
