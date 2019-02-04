namespace App.Utils { 
    
    public string? last_path = null;

    public Gtk.FileChooserDialog new_file_chooser_dialog (string title, Gtk.Window? parent) {
        var all_files_filter = new Gtk.FileFilter ();
        all_files_filter.set_filter_name (_("All files"));
        all_files_filter.add_pattern ("*");

        var text_files_filter = new Gtk.FileFilter ();
        text_files_filter.set_filter_name (_("Text files"));
        text_files_filter.add_mime_type ("text/*");

        var filech = new Gtk.FileChooserDialog (title, parent, Gtk.FileChooserAction.SAVE);
        filech.add_button (_("Cancel"), Gtk.ResponseType.CANCEL);
        filech.add_filter (all_files_filter);
        filech.add_filter (text_files_filter);
        filech.set_current_folder_uri (Utils.last_path ?? GLib.Environment.get_home_dir ());
        filech.set_default_response (Gtk.ResponseType.ACCEPT);
  
        filech.add_button (_("Save"), Gtk.ResponseType.ACCEPT);
        
        filech.key_press_event.connect ((ev) => {
            if (ev.keyval == 65307) // Esc key
                filech.destroy ();
            return false;
        });

        return filech;
    }
}