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

    public class GitignoreView : Gtk.Grid {

        private Gtk.SourceView source_view;
        public Gtk.SourceBuffer source_buffer;
        private Soup.Session session;

        public GitignoreView () {
            Object (
                hexpand: true,
                margin: 10,
                row_spacing: 10,
                vexpand: true
            );

            session = new Soup.Session();            
        }

        construct {
            source_buffer = new Gtk.SourceBuffer (null);
            source_buffer.language = Gtk.SourceLanguageManager.get_default ().get_language ("text");
            source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");
            
            source_view = new App.Widgets.SourceView (source_buffer);

            var scroll_window = new Gtk.ScrolledWindow (null, null);
            scroll_window.hscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.expand = true;
            scroll_window.add (source_view);
            scroll_window.get_style_context ().add_class ("code");

            attach (scroll_window, 0, 0, 1, 1);          
        }

        public void load_data () {
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");
            string[] data = settings.get_strv ("selected-langs");
            string uri = "https://www.gitignore.io/api/";

            for (int i = 0; i < data.length; i++) {
                uri = uri + data[i] + ",";
            }

            uri = uri.slice (0, uri.length-1);
            
            var message = new Soup.Message ("GET", uri);
            session.queue_message (message, (sess, mess) => {
                if (mess.status_code == 200) {
                        source_buffer.text = (string) mess.response_body.flatten ().data;
                        source_view.buffer = source_buffer;
                } else {
                    show_message(_("Request failed. Please check your network connection."), @"status code: $(mess.status_code)", "dialog-error");
                }
            });
        }

        private void show_message (string txt_primary, string txt_secondary, string icon) {
            var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                txt_primary,
                txt_secondary,
                icon,
                Gtk.ButtonsType.CLOSE
            );

            message_dialog.run ();
            message_dialog.destroy ();
        }
    }
}
