namespace App.Views {

    public class GitignoreView : Gtk.Grid {

        private Gtk.SourceView source_view;
        private Gtk.SourceBuffer source_buffer;
        private Gtk.ScrolledWindow scroll_window;
        private Soup.Session session;

        public GitignoreView () {
            Object (
                hexpand: true,
                row_spacing: 10,
                margin: 10,
                vexpand: true
            );
            session = new Soup.Session();            
        }

        construct {
            source_buffer = new Gtk.SourceBuffer (null);
            source_buffer.highlight_syntax = true;
            source_view.expand = true;
            source_buffer.language = Gtk.SourceLanguageManager.get_default ().get_language ("text");
            
            source_buffer.text = "";
            source_buffer.style_scheme = new Gtk.SourceStyleSchemeManager ().get_scheme ("solarized-light");
            
            source_view = new Gtk.SourceView ();
            source_view.buffer = source_buffer;
            source_view.editable = false;
            source_view.monospace = true;
            source_view.expand = true;
            source_view.show_line_numbers = false;
            source_view.left_margin = source_view.right_margin = 6;
            source_view.pixels_above_lines = source_view.pixels_below_lines = 3;

            scroll_window = new Gtk.ScrolledWindow (null, null);
            scroll_window.hscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll_window.expand = true;
            scroll_window.add (source_view);


            attach (scroll_window, 0, 0, 1, 1);

            scroll_window.get_style_context ().add_class ("code");
        }

        public void load_data () {
            var settings = new GLib.Settings ("com.github.arshubham.gitignore");
            string[] data = settings.get_strv ("selected-langs");
            string uri = "https://www.gitignore.io/api/";
            for (int i = 0; i < data.length; i++) {
                uri = uri + data[i] + ",";
            }
            uri = uri.slice (0, uri.length-1);
            debug (uri);
            var message = new Soup.Message ("GET", uri);
            session.queue_message (message, (sess, mess) => {
                if (mess.status_code == 200) {
                        source_buffer.text = (string) mess.response_body.flatten ().data;
                        source_view.buffer = source_buffer;
                } else {
                    show_message("Request page fail", @"status code: $(mess.status_code)", "dialog-error");
                }
            });
        }

        private void show_message (string txt_primary, string txt_secondary, string icon) {
            var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                txt_primary,
                txt_secondary,
                icon,
                Gtk.ButtonsType.CLOSE
            );

            message_dialog.run ();
            message_dialog.destroy ();
        }
    }
}
