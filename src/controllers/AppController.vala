/*
* Copyright (C) 2018  Shubham Arora <shubhamarora@protonmail.com>
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
*/

using App.Widgets;
using App.Views;

namespace App.Controllers {

    /**
     * The {@code AppController} class.
     *
     * @since 1.0.0
     */
    public class AppController {

        private Gtk.Application            application;
        private AppView                    app_view;
        private Widgets.HeaderBar              headerbar;
        private Gtk.ApplicationWindow      window { get; private set; default = null; }
        private Gdk.Display                display;
        /**
         * Constructs a new {@code AppController} object.
         */
        public AppController (Gtk.Application application) {
            this.application = application;
            this.window = new Window (this.application);
            this.headerbar = new HeaderBar ();
            display = window.get_display ();

            this.app_view = new AppView (display);

            this.window.add (this.app_view);
            this.window.set_default_size (1000, 740);
            this.window.set_size_request (1000, 740);
            this.window.set_titlebar (this.headerbar);
            this.application.add_window (window);

            var ds = this.headerbar.get_dark_switch ();
            ds.notify["active"].connect (() => {
                var settings = App.Configs.Settings.get_instance ();
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
