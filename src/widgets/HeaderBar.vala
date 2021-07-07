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

public class Gitignore.Widgets.HeaderBar : Gtk.HeaderBar {
    public Gitignore.Widgets.SearchEntry search_entry;
    private Gitignore.Widgets.EntryCompletion entry_completion;

    private Gtk.Switch dark_switch;
    private Gtk.Image light_icon;
    private Gtk.Image dark_icon;

    private Gee.HashSet<string> selected_languages;

    private Gitignore.Widgets.BookmarksPopover bookmarks_popover;
    private Gtk.Button bookmarks_popver_button;

    private Gtk.ApplicationWindow window;

    public signal void switch_theme ();
    public signal void changed ();

    public HeaderBar (Gtk.ApplicationWindow window) {
        Object (
            has_subtitle: false,
            show_close_button: true,
            title: Gitignore.Constants.APP_NAME
        );

        // Allows window to be dragged when search_entry is empty
        search_entry.button_press_event.connect ((event)=>{
            search_entry.grab_focus_without_selecting ();
            if (search_entry.text_length > 0) {
                return false;
            } else {
                return true;
            }
        });

        this.window = window;

        var settings = new GLib.Settings ("com.github.arshubham.gitignore");

        selected_languages = new Gee.HashSet<string> ();

        var data_set = Gitignore.Utils.DataUtils.DATA;

        Gee.ArrayList<string> list = new Gee.ArrayList<string> ();
        for (int i = 0; i < data_set.length; i++) {
            list.add (data_set[i]);
        }

        search_entry.activate.connect (() => {
            string[] data = settings.get_strv ("selected-langs");

            if (data.length == 0) {
                selected_languages.clear ();
            }

            GenericArray<string> array = new GenericArray<string> ();
            for (var i = 0; i < data.length; i++) {
                array.add (data[i]);
            }

            var entered_language = search_entry.text;
            array.add (entered_language);

            string[] output = array.data;

            if (list.contains (entered_language) && !selected_languages.contains (entered_language) && entered_language.strip ().length != 0) {
                settings.set_strv ("selected-langs", output);
            } else if (selected_languages.contains (entered_language)) {
                debug ("Selected Language already entered.");
            } else {
                debug ("Unknown Language.");
            }

            for (int i = 0 ; i < output.length; i++) {
                selected_languages.add (output [i]);
            }

            changed ();
        });

        var window_settings = Gtk.Settings.get_default ();

        bool prefer_dark;
        settings.get ("prefer-dark", "b", out prefer_dark );

        if (prefer_dark) {
            dark_switch.active = true;
            window_settings.gtk_application_prefer_dark_theme = true;
        } else {
            dark_switch.active = false;
            window_settings.gtk_application_prefer_dark_theme = false;
        }

        dark_switch.notify["active"].connect (() => {
            if (dark_switch.active) {
                window_settings.gtk_application_prefer_dark_theme = true;
                settings.set ("prefer-dark", "b", true );
            } else {
                window_settings.gtk_application_prefer_dark_theme = false;
                settings.set ("prefer-dark", "b", false );
            }
            switch_theme ();
        });

        set_custom_title (search_entry);
    }

    construct {
        entry_completion = new Gitignore.Widgets.EntryCompletion ();
        search_entry = new Gitignore.Widgets.SearchEntry (entry_completion);

        bookmarks_popver_button = new Gtk.Button ();
        bookmarks_popver_button.set_image (new Gtk.Image.from_icon_name ("user-bookmarks", Gtk.IconSize.LARGE_TOOLBAR));
        bookmarks_popver_button.clicked.connect (show_hide_popover);

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
        pack_end (bookmarks_popver_button);

        get_style_context ().add_class ("flat");
    }

    private void show_hide_popover () {
        bookmarks_popover = new Gitignore.Widgets.BookmarksPopover (bookmarks_popver_button, window);
        bookmarks_popover.show_all ();
    }
}