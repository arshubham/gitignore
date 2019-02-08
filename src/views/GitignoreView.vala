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
        private Gtk.ScrolledWindow scroll_window;

        private Soup.Session session;

        public GitignoreView () {
            Object (
                hexpand: true,
                margin: 10,
                row_spacing: 10,
                vexpand: true
            );

            session = new Soup.Session ();

            update_theme ();
        }

        construct {
            source_buffer = new Gtk.SourceBuffer (null);
            source_buffer.language = Gtk.SourceLanguageManager.get_default ().get_language ("text");
            source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");

            source_view = new App.Widgets.SourceView (source_buffer);

            scroll_window = new Gtk.ScrolledWindow (null, null);
            scroll_window.hscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.expand = true;
            scroll_window.add (source_view);
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
                    show_message (_("Request failed. Please check your network connection."), @"status code: $(mess.status_code)", "dialog-error");
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

        public void update_theme () {
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");

            bool prefer_dark;
            settings.get ("prefer-dark", "b", out prefer_dark );

            if (prefer_dark) {
                source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-dark");
                scroll_window.get_style_context ().remove_class ("code");
                scroll_window.get_style_context ().add_class ("code_dark");
            } else {
                source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");
                scroll_window.get_style_context ().remove_class ("code_dark");
                scroll_window.get_style_context ().add_class ("code");
            }
            source_view.buffer = source_buffer;
        }
    }
}
