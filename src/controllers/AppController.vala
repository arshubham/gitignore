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

public class Gitignore.Controller {

    private Gitignore.Application application;
    private Gitignore.Views.AppView app_view;
    private Gitignore.Widgets.HeaderBar headerbar;
    private Gtk.ApplicationWindow window { get; private set; default = null; }
    private Gdk.Display display;

    public Controller (Gitignore.Application application) {
        this.application = application;
        window = new Gitignore.Window (this.application);
        headerbar = new Gitignore.Widgets.HeaderBar (window);
        display = window.get_display ();

        var db = new Gitignore.Services.Database ();
        app_view = new Gitignore.Views.AppView (display, window);
        
        headerbar.changed.connect (() => {
            app_view.update_tags ();
            int window_width, window_height;
            window.get_size (out window_width, out window_height);
            window.resize (window_width+1, window_height);
            headerbar.search_entry.grab_focus_without_selecting ();
            window.get_size (out window_width, out window_height);
            window.resize (window_width-1, window_height);
        });

        headerbar.switch_theme.connect (() => {
            app_view.update_tags ();
        });

        window.add (app_view);
        window.set_titlebar (headerbar);
        application.add_window (window);
    }

    public void activate () {
        window.show_all ();
        app_view.activate ();
    }

    public void quit () {
        window.destroy ();
    }
}