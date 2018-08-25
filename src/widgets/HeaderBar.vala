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

/*
* TODO: Extract Gtk.SearchEntry and Gtk.EntryCompletion to a seperate class
*/

/*
* FIXME: Fix Dark and Light Theme switch
*/
using App.Configs;

namespace App.Widgets {

    public class HeaderBar : Gtk.HeaderBar {
        private Gtk.SearchEntry search_entry;
        private Gtk.EntryCompletion entry_completion;

        private Gtk.Switch dark_switch;
        private Gtk.Image light_icon;
        private Gtk.Image dark_icon;

        private Gee.HashSet<string> selected_languages;

        public HeaderBar () {
            Object (
                title: _("GitIgnore"),
                has_subtitle: false
            );

            search_entry = new Gtk.SearchEntry ();
            search_entry.placeholder_text = _("Select a Language from the dropdown and press enter.");
            search_entry.hexpand = true;
            search_entry.valign = Gtk.Align.CENTER;
            search_entry.grab_focus_without_selecting ();

            dark_switch = new Gtk.Switch ();
            dark_switch.valign = Gtk.Align.CENTER;
            dark_switch.get_style_context ().add_class (Granite.STYLE_CLASS_MODE_SWITCH);
            light_icon = new Gtk.Image.from_icon_name ("display-brightness-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            light_icon.tooltip_text = _("Light background");
            dark_icon = new Gtk.Image.from_icon_name ("weather-clear-night-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            dark_icon.tooltip_text = _("Dark background");

            if (App.Configs.Settings.get_instance ().prefer_dark) {
                dark_switch.active = true;
            } else {
                dark_switch.active = false;
            }

            dark_switch.notify["active"].connect (() => {
                var window_settings = Gtk.Settings.get_default ();
                var settings = App.Configs.Settings.get_instance ();
                if (dark_switch.active) {
                    window_settings.gtk_application_prefer_dark_theme = true;
                    settings.prefer_dark = true;
                } else {
                    window_settings.gtk_application_prefer_dark_theme = false;
                    settings.prefer_dark = false;
                }

            });

            entry_completion = new Gtk.EntryCompletion ();
            search_entry.set_completion (entry_completion);
            entry_completion.inline_selection = true;
            entry_completion.inline_completion = true;
            entry_completion.popup_single_match = false;

            string[] data = DataSet.DATA;

            var list_store = new Gtk.ListStore (1, typeof (string));
		    entry_completion.set_model (list_store);
            entry_completion.set_text_column (0);

            Gtk.TreeIter iter;
            for (int i = 0; i < data.length ; i++) {
                list_store.append (out iter);
                list_store.set (iter, 0, data[i]);
            }

            selected_languages = new Gee.HashSet<string> ();

            Gee.ArrayList<string> list = new Gee.ArrayList<string> ();
            for (int i = 0; i < data.length; i++) {
                list.add (data[i]);
            }

            search_entry.activate.connect (() => {
                string entered_language = search_entry.text;
                if (list.contains (entered_language) && !selected_languages.contains(entered_language) && entered_language.strip ().length != 0) {
                    selected_languages.add(entered_language);
                    debug ("Selected Language: %s\n", entered_language);
                } else if (selected_languages.contains(entered_language)) {
                    debug ("Selected Language: %s, already in the set\n", entered_language);
                } else {
                    debug ("Unknown Language\n");
                }
            });

            set_custom_title (search_entry);
            pack_end (dark_icon);
            pack_end (dark_switch);
            pack_end (light_icon);
            show_close_button = true;
        }

        public Gtk.Switch get_dark_switch () {
            return this.dark_switch;
        }

        public Gtk.SearchEntry get_search_entry () {
            return this.search_entry;
        }

        public Gee.HashSet<string> get_selected_languages (){
            return this.selected_languages;
        }
    }
}
