namespace App.Views {

    public class WelcomeView : Gtk.Grid {
        public WelcomeView () {
            Object (
                halign: Gtk.Align.CENTER,
                hexpand: true,
                margin_bottom: 200,
                row_spacing: 10,
                valign: Gtk.Align.CENTER,
                vexpand: true
            );
        }

        construct {
            var title = new Gtk.Label ("gitIgnore");
            title.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);

            var subtitle = new Gtk.Label (_(".gitignore reference for various languages"));

            var usage_instructions = _("Select a Language from the dropdown and press enter."
                       + "The selected languages will appear as tags. Press \"Generate .gitignore\""
                       + "to fetch .gitignore file.");

            var copy = new Gtk.Label ("<b>%s</b>".printf (usage_instructions));
            copy.margin = 24;
            copy.max_width_chars = 70;
            copy.use_markup = true;
            copy.wrap = true;

            attach (title, 0, 0);
            attach (subtitle, 0, 1);
            attach (copy, 0, 2);
            get_style_context ().add_class (Granite.STYLE_CLASS_WELCOME);
        }
    }
}
