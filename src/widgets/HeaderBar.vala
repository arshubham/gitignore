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

/*
* TODO: Extract Gtk.SearchEntry and Gtk.EntryCompletion to a seperate class
*/

/*
* FIXME: Fix Dark and Light Theme switch
*/

namespace App.Widgets {

    public class HeaderBar : Gtk.HeaderBar {
        private App.Widgets.SearchEntry search_entry;
        private App.Widgets.EntryCompletion entry_completion;

        private Gtk.Switch dark_switch;
        private Gtk.Image light_icon;
        private Gtk.Image dark_icon;

        private Gee.HashSet<string> selected_languages;

        public signal void switch_theme (bool prefer_dark);

        public HeaderBar () {
            Object (
                has_subtitle: false,
                show_close_button: true,
                title: App.Configs.Constants.APP_NAME
            );
            entry_completion = new App.Widgets.EntryCompletion ();
            search_entry = new App.Widgets.SearchEntry (entry_completion);

            selected_languages = new Gee.HashSet<string> ();
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");
            
            search_entry.activate.connect (() => {
                string currently_selected_languages;
                settings.get ("selected-langs", "s", out currently_selected_languages );
                string entered_language = search_entry.text;
                settings.set_string ("selected-langs", currently_selected_languages + entered_language + ",");
            });

            set_custom_title (search_entry);
            var window_settings = Gtk.Settings.get_default ();

            

            bool prefer_dark;
            settings.get ("prefer-dark", "b", out prefer_dark );

            if (prefer_dark) {
                dark_switch.active = true;
                window_settings.gtk_application_prefer_dark_theme = true;
                switch_theme (true);
            } else {
                dark_switch.active = false;
                window_settings.gtk_application_prefer_dark_theme = false;
                switch_theme (false);
            }

            dark_switch.notify["active"].connect (() => {
                if (dark_switch.active) {
                    window_settings.gtk_application_prefer_dark_theme = true;
                    settings.set ("prefer-dark", "b", true );
                } else {
                    window_settings.gtk_application_prefer_dark_theme = false;
                    settings.set ("prefer-dark", "b", false );
                }
            });
            show_close_button = true;
        }

        construct {
            get_style_context ().add_class ("flat");
            dark_switch = new Gtk.Switch ();
            dark_switch.valign = Gtk.Align.CENTER;
            dark_switch.get_style_context ().add_class (Granite.STYLE_CLASS_MODE_SWITCH);

            light_icon = new Gtk.Image.from_icon_name ("display-brightness-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            light_icon.tooltip_text = _("Light background");

            dark_icon = new Gtk.Image.from_icon_name ("weather-clear-night-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            dark_icon.tooltip_text = _("Dark background");

            pack_end (dark_icon);
            pack_end (dark_switch);
            pack_end (light_icon);
        }

        public Gtk.SearchEntry get_search_entry () {
            return this.search_entry;
        }

        public Gee.HashSet<string> get_selected_languages (){
            return this.selected_languages;
        }
    }
}
