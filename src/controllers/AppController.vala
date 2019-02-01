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

namespace App.Controllers {

    public class AppController {

        private Gtk.Application application;
        private App.Views.AppView app_view;
        private App.Widgets.HeaderBar headerbar;
        private Gtk.ApplicationWindow window { get; private set; default = null; }
        private Gdk.Display display;

        public AppController (Gtk.Application application) {
            this.application = application;
            this.window = new Window (this.application);
            this.headerbar = new App.Widgets.HeaderBar ();

            var selected_languages = this.headerbar.get_selected_languages ();

            var search_entry = this.headerbar.get_search_entry ();

            search_entry.activate.connect (() => {
                this.app_view.update_langs (selected_languages);
            });

            display = window.get_display ();

            this.app_view = new App.Views.AppView (display, selected_languages);

            this.window.add (this.app_view);
            this.window.set_default_size (900, 540);
            this.window.set_size_request (900, 540);
            this.window.set_gravity (Gdk.Gravity.CENTER);
            this.window.set_titlebar (this.headerbar);
            this.application.add_window (window);

            var ds = this.headerbar.get_dark_switch ();
            ds.notify["active"].connect (() => {
                if (ds.active) {
                    app_view.dark_theme ();
                } else {
                    app_view.light_theme ();
                }

            });
        }

        public void activate () {
            window.show_all ();
            app_view.activate ();
        }

        public void quit () {
            window.destroy ();
        }
    }
}
