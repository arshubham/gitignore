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
*
* Authored by: Shubham Arora <shubhamarora@protonmail.com>
*/

using App.Configs;
using App.Controllers;
using App.Views;

namespace App {

    public class Window : Gtk.ApplicationWindow {
         
        public Window (Gtk.Application app) {
            Object (
                application: app,
                deletable: true,
                gravity: Gdk.Gravity.CENTER,
                icon_name: App.Configs.Constants.APP_ICON,
                resizable: true,
                title: App.Configs.Constants.APP_NAME
            );

            var settings = new GLib.Settings ("com.github.arshubham.cipher");

            int window_x, window_y;
            settings.get ("window-position", "(ii)", out window_x, out window_y);

            if (window_x != -1 || window_y != -1) {
                move (window_x, window_y);
            }

            int window_width, window_height;
            settings.get ("window-size", "(ii)", out window_width, out window_height);

            set_default_size (window_width, window_height);

            if (settings.get_boolean ("window-maximized")) {
                this.maximize ();
            }

            delete_event.connect (() => {
                if (this.is_maximized) {
                    settings.set_boolean ("window-maximized", true);
                } else {
                    settings.set_boolean ("window-maximized", false);

                    int width, height;
                    get_size (out width, out height);
                    debug (width.to_string ());
                    settings.set ("window-size", "(ii)", width, height);

                    int root_x, root_y;
                    get_position (out root_x, out root_y);
                    settings.set ("window-position", "(ii)", root_x, root_y);
                }
                return false;
            });

            style_provider ();
        }

        private void style_provider () {
            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource (App.Configs.Constants.URL_CSS);

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }
    }
}
