/*
* Copyright (c) 2018 Alain M. (https://github.com/alainm23/planner)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alain M. <alain23@protonmail.com>
*/

namespace ColorView {
    public class MainWindow : Gtk.Window {
        private Widgets.ColorButton color_button;
        private Gtk.Entry hex_entry;
        private Gtk.Entry r_entry;
        private Gtk.Entry g_entry;
        private Gtk.Entry b_entry;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.alainm23.colorview",
                resizable: false,
                width_request: 500,
                height_request: 600,
                title: _("Color View"),
                window_position: Gtk.WindowPosition.CENTER
            );


            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/colorview");

            build_ui ();
        }

        private void build_ui () {
            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = _("Color View");
            headerbar.show_close_button = true;
            headerbar.get_style_context ().add_class ("titlebar");
            headerbar.get_style_context ().add_class ("default-decoration");
            headerbar.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.margin_left = 24;
            main_grid.margin_top = 12;
            main_grid.margin_right = 24;

            color_button = new Widgets.ColorButton ();

            hex_entry = new Gtk.Entry ();
            hex_entry.placeholder_text = "#3689e6";
            hex_entry.max_length = 7;

            var hex_label = new Gtk.Label (_("<b>Hex</b>"));
            hex_label.halign = Gtk.Align.END;
            hex_label.margin_right = 12;
            hex_label.use_markup = true;
            hex_label.get_style_context ().add_class ("h3");

            var hex_box = new Gtk.Grid ();
            hex_box.margin_top = 24;
            hex_box.halign = Gtk.Align.END;
            //hex_box.column_homogeneous = true;
            hex_box.attach (hex_label, 0, 0, 1, 1);
            hex_box.attach (hex_entry, 1, 0, 1, 1);

            r_entry = new Gtk.Entry ();
            r_entry.placeholder_text = "0-255";
            r_entry.max_length = 3;

            g_entry = new Gtk.Entry ();
            g_entry.placeholder_text = "0-255";
            g_entry.max_length = 3;

            b_entry = new Gtk.Entry ();
            b_entry.placeholder_text = "0-255";
            b_entry.max_length = 3;

            var box = new Gtk.Grid ();
            box.add (r_entry);
            box.add (g_entry);
            box.add (b_entry);

            var rgb_label = new Gtk.Label (_("<b>RGB</b>"));
            rgb_label.halign = Gtk.Align.END;
            rgb_label.margin_right = 12;
            rgb_label.use_markup = true;
            rgb_label.get_style_context ().add_class ("h3");

            var rgb_box = new Gtk.Grid ();
            rgb_box.margin_top = 12;
            rgb_box.halign = Gtk.Align.END;
            rgb_box.attach (rgb_label, 0, 0, 1, 1);
            rgb_box.attach (box, 1, 0, 1, 1);

            // All Signals
            hex_entry.activate.connect ( () => {
                if (hex_entry.text != "") {
                    color_button.set_color (hex_entry.text);
                }
            });

            hex_entry.changed.connect ( () => {
                if (hex_entry.text != "") {
                    color_button.set_color (hex_entry.text);
                }
            });

            main_grid.add (color_button);
            main_grid.add (hex_box);
            //main_grid.add (rgb_box);

            set_titlebar (headerbar);
            add (main_grid);
            show_all ();
        }
    }
}
