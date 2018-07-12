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

using App.Configs;
using App.Widgets;

namespace App.Views {

    /**
     * The {@code AppView} class.
     *
     * @since 1.0.0
     */
    public class AppView : Gtk.Grid {

        /**
         * Constructs a new {@code AppView} object.
         */
            private Gtk.ScrolledWindow terminal_output;
            private Gtk.SourceView source_view;
            public string language;
        construct {
            Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            Gtk.Box content =new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            Gtk.Button button1 = new Gtk.Button.with_label ("Click me (0)");
            Gtk.Button button2 = new Gtk.Button.with_label ("Click me (0)");
            Gtk.Button button3 = new Gtk.Button.with_label ("Click me (0)");
            Gtk.Button button4 = new Gtk.Button.with_label ("Click me (0)");
            Gtk.Button button5 = new Gtk.Button.with_label ("Copy to clipboard");
            Gtk.Button button6 = new Gtk.Button.with_label ("Save as .gitignore");
            content.pack_start (button1, false, false, 0);
            content.pack_start (button2, false, false, 0);
            content.pack_start (button3, false, false, 0);
            content.pack_start (button4, false, false, 0);
            content.pack_end (button5, false, false, 0);
            content.pack_end (button6, false, false, 0);
            button1.get_style_context ().add_class (Granite.STYLE_CLASS_BACK_BUTTON);
            button2.get_style_context ().add_class (Granite.STYLE_CLASS_BACK_BUTTON);
            button3.get_style_context ().add_class (Granite.STYLE_CLASS_BACK_BUTTON);
            button4.get_style_context ().add_class (Granite.STYLE_CLASS_BACK_BUTTON);
            
            var source_buffer = new Gtk.SourceBuffer (null);
            source_buffer.highlight_syntax = true;
            source_buffer.language = Gtk.SourceLanguageManager.get_default ().get_language ("vala");
            source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");

            source_view = new Gtk.SourceView ();


            source_buffer.text = "var source_view = new Gtk.SourceView ();
            source_view.buffer = source_buffer;
            source_view.editable = false;
            source_view.left_margin = source_view.right_margin = 6;
            source_view.monospace = true;
            source_view.pixels_above_lines = source_view.pixels_below_lines = 3;
            source_view.show_line_numbers = true;
    
            var snippet = new Gtk.Grid ();
            snippet.add (source_view);
    
            content_area.column_spacing = 12;
            content_area.row_spacing = 12;
            content_area.orientation = Gtk.Orientation.VERTICAL;
            content_area.add (color_title);
            content_area.add (color_row);
            content_area.add (symbolic_title);
            content_area.add (symbolic_row);
            content_area.add (snippet_title);
            content_area.add (snippet)
            var source_view = new Gtk.SourceView ();
            source_view.buffer = source_buffer;
            source_view.editable = false;
            source_view.left_margin = source_view.right_margin = 6;
            source_view.monospace = true;
            source_view.pixels_above_lines = source_view.pixels_below_lines = 3;
            source_view.show_line_numbers = true;
    
            var snippet = new Gtk.Grid ();
            snippet.add (source_view);
    
            content_area.column_spacing = 12;
            content_area.row_spacing = 12;
            content_area.orientation = Gtk.Orientation.VERTICAL;
            content_area.add (color_title);
            content_area.add (color_row);
            content_area.add (symbolic_title);
            content_area.add (symbolic_row);
            content_area.add (snippet_title);
            content_area.add (snippet)";


            source_view.buffer = source_buffer;
            source_view.editable = false;
            source_view.monospace = true;
            source_view.show_line_numbers = true;
            //get_style_context ().add_class ("code");
            terminal_output = new Gtk.ScrolledWindow (null, null);
            terminal_output.hscrollbar_policy = Gtk.PolicyType.NEVER;
            terminal_output.expand = true;
            terminal_output.add (source_view); 
            box.pack_start (content, false, true, 0);
		    box.pack_start (terminal_output, false, true, 0);   
            attach (box, 0, 0, 3, 1);
        }
    }
}