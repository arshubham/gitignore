/*
* Copyright (C) 2018-2019  Shubham Arora <shubhamarora@protonmail.com>
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

namespace App {

    public class Application : Gtk.Application {

        public App.Controllers.AppController controller;

        public Application () {
            Object (
                application_id: App.Configs.Constants.ID,
                flags: ApplicationFlags.FLAGS_NONE
            );

            var quit_action = new SimpleAction ("quit", null);
            quit_action.activate.connect (() => {
                controller.quit ();
            });

            add_action (quit_action);
            set_accels_for_action ("app.quit", {"<Control>q"});
        }

        public override void activate () {
            if (controller == null) {
                controller = new App.Controllers.AppController (this);
            }

            controller.activate ();
        }
    }
}
