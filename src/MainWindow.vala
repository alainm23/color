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
        private Gtk.Switch dark_siwtch;
        private Widgets.ColorButton color_button;
        private Gtk.Entry hex_entry;
        private Gtk.SpinButton r_button;
        private Gtk.SpinButton g_button;
        private Gtk.SpinButton b_button;
        private Gtk.SpinButton a_button;

        private bool rgb_changed = false;

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

            //dark_siwtch = new Gtk.Switch ();
            //headerbar.pack_end (dark_siwtch);

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.margin_left = 24;
            main_grid.margin_top = 12;
            main_grid.margin_right = 24;

            color_button = new Widgets.ColorButton ();

            hex_entry = new Gtk.Entry ();
            hex_entry.text = "#7a36b1";
            hex_entry.placeholder_text = "#7a36b1";
            hex_entry.max_length = 7;
            hex_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-copy");

            r_button = new Gtk.SpinButton.with_range (0, 255, 1);
            r_button.tooltip_text = _("Red");

            g_button = new Gtk.SpinButton.with_range (0, 255, 1);
            g_button.tooltip_text = _("Green");

            b_button = new Gtk.SpinButton.with_range (0, 255, 1);
            b_button.tooltip_text = _("Blue");

            var rgb_box = new Gtk.Grid ();
            rgb_box.column_spacing = 6;
            rgb_box.add (r_button);
            rgb_box.add (g_button);
            rgb_box.add (b_button);

            // All Signals
            hex_entry.changed.connect ( () => {
                rgb_changed = false;
                change_color ();
            });

            r_button.value_changed.connect ( () => {
                rgb_changed = true;
                change_color ();
            });

            g_button.value_changed.connect ( () => {
                rgb_changed = true;
                change_color ();
            });

            b_button.value_changed.connect ( () => {
                rgb_changed = true;
                change_color ();
            });

            hex_entry.icon_press.connect ( (pos, event) => {
                if (pos == Gtk.EntryIconPosition.SECONDARY) {
                    Gtk.Clipboard.get_default (this.get_display ()).set_text (hex_entry.text, -1);
                }
            });

            r_button.value = rgb_color ("r");
            g_button.value = rgb_color ("g");
            b_button.value = rgb_color ("b");


            main_grid.add (color_button);
            main_grid.add (new Granite.HeaderLabel (_("Hex")));
            main_grid.add (hex_entry);
            main_grid.add (new Granite.HeaderLabel (_("RGB")));
            main_grid.add (rgb_box);

            set_titlebar (headerbar);
            add (main_grid);
            show_all ();
        }

        private string hex_string () {
            string s = "#%02x%02x%02x"
                .printf((uint) (r_button.value),
                        (uint) (g_button.value),
                        (uint) (b_button.value));
            return s;
        }

        private double rgb_color (string type) {
             Gdk.RGBA color = Gdk.RGBA ();
             color.parse (hex_entry.text);

             if (type == "r") {
                 return color.red * 255;
             } else if (type == "g") {
                 return color.green * 255;
             } else {
                 return color.blue * 255;
             }
        }

        private void change_color () {
            string hex = "";

            if (rgb_changed) {
                hex = hex_string ();
            } else {
                if (hex_entry.text != "") {
                    hex = hex_entry.text;
                }
            }
            /*
            hex_entry.text = hex;

            r_button.value = rgb_color ("r");
            g_button.value = rgb_color ("g");
            b_button.value = rgb_color ("b");
            */
            color_button.set_color (hex);
        }
    }
}
