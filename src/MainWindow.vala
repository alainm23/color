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

        private Gtk.Label rgba_format_label;

        private Granite.Widgets.ModeButton mode_button;
        private Gtk.Stack main_stack;

        private Gtk.SpinButton h_button;
        private Gtk.SpinButton s_button;
        private Gtk.SpinButton l_button;

        private string hex_main = "#7a36b1";

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
            color_button.set_color ("#7a36b1");

            var hex_grid = new Gtk.Grid ();
            hex_grid.margin_top = 24;
            hex_grid.orientation = Gtk.Orientation.VERTICAL;

            hex_entry = new Gtk.Entry ();
            hex_entry.text = "#7a36b1";
            hex_entry.placeholder_text = "#7a36b1";
            hex_entry.max_length = 7;
            hex_entry.hexpand = true;
            hex_entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-copy");

            hex_grid.add (hex_entry);

            var rgba_grid = new Gtk.Grid ();
            rgba_grid.margin_top = 24;
            rgba_grid.orientation = Gtk.Orientation.VERTICAL;
            rgba_grid.halign = Gtk.Align.CENTER;
            rgba_grid.column_spacing = 12;

            rgba_format_label = new Gtk.Label ("");
            rgba_format_label.use_markup = true;
            rgba_format_label.selectable = true;

            r_button = new Gtk.SpinButton.with_range (0, 255, 1);
            r_button.tooltip_text = _("Red");

            g_button = new Gtk.SpinButton.with_range (0, 255, 1);
            g_button.tooltip_text = _("Green");

            b_button = new Gtk.SpinButton.with_range (0, 255, 1);
            b_button.tooltip_text = _("Blue");

            a_button = new Gtk.SpinButton.with_range (0, 1, 0.1);
            a_button.tooltip_text = _("Alpha");

            var r_label = new Granite.HeaderLabel (_("Red"));
            r_label.halign = Gtk.Align.END;

            var g_label = new Granite.HeaderLabel (_("Green"));
            g_label.halign = Gtk.Align.END;

            var b_label = new Granite.HeaderLabel (_("Blue"));
            b_label.halign = Gtk.Align.END;

            var a_label = new Granite.HeaderLabel (_("Alpha"));
            a_label.halign = Gtk.Align.END;


            rgba_grid.attach (new Granite.HeaderLabel (_("Format")), 0, 0, 1, 1);
            rgba_grid.attach (rgba_format_label, 1, 0, 1, 1);
            rgba_grid.attach (r_label, 0, 1, 1, 1);
            rgba_grid.attach (r_button, 1, 1, 1, 1);
            rgba_grid.attach (g_label, 0, 2, 1, 1);
            rgba_grid.attach (g_button, 1, 2, 1, 1);
            rgba_grid.attach (b_label, 0, 3, 1, 1);
            rgba_grid.attach (b_button, 1, 3, 1, 1);
            rgba_grid.attach (a_label, 0, 4, 1, 1);
            rgba_grid.attach (a_button, 1, 4, 1, 1);

            var hlsa_grid = new Gtk.Grid ();

            mode_button = new Granite.Widgets.ModeButton ();
            mode_button.margin_top = 24;
            mode_button.hexpand = true;
            mode_button.halign = Gtk.Align.CENTER;

            main_stack = new Gtk.Stack ();
            main_stack.expand = true;
            main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;

            main_stack.add_named (hex_grid, "hex_grid");
            main_stack.add_named (rgba_grid, "rgba_grid");
            main_stack.add_named (hlsa_grid, "hlsa_grid");

            mode_button.append_text (_("Hex"));
            mode_button.append_text (_("RGBA"));
            mode_button.append_text (_("HSLA"));

            mode_button.selected = 0;

            h_button = new Gtk.SpinButton.with_range (0, 360, 1);
            h_button.tooltip_text = _("Hue");

            s_button = new Gtk.SpinButton.with_range (0, 100, 1);
            s_button.tooltip_text = _("Saturation");

            l_button = new Gtk.SpinButton.with_range (0, 100, 1);
            l_button.tooltip_text = _("Lightness");

            var hsl_box = new Gtk.Grid ();
            hsl_box.column_spacing = 6;
            hsl_box.add (h_button);
            hsl_box.add (s_button);
            hsl_box.add (l_button);

            // All Signals
            hex_entry.changed.connect ( () => {
                hex_main = hex_entry.text;
                color_button.set_color (hex_main);
            });

            r_button.value_changed.connect (change_color);
            g_button.value_changed.connect (change_color);
            b_button.value_changed.connect (change_color);
            a_button.value_changed.connect (change_color);

            mode_button.mode_changed.connect ( (widget) => {
                if (mode_button.selected == 0) {
                    main_stack.visible_child_name = "hex_grid";
                    hex_entry.text = hex_main;
                } else if (mode_button.selected == 1) {
                    main_stack.visible_child_name = "rgba_grid";
                    // Aqui esta el otro docigo
                    change_color ();
                } else if (mode_button.selected == 2) {
                    main_stack.visible_child_name = "hlsa_grid";
                }
            });

            main_grid.add (color_button);
            main_grid.add (mode_button);
            main_grid.add (main_stack);

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
             color.parse (hex_main);

             if (type == "r") {
                 return color.red * 255;
             } else if (type == "g") {
                 return color.green * 255;
             } else if (type == "a") {
                     return color.alpha * 255;
             } else {
                 return color.blue * 255;
             }
        }

        private void change_color () {
            hex_main = hex_string ();

            string r = r_button.value.to_string ();
            string g = g_button.value.to_string ();
            string b = b_button.value.to_string ();
            string a = a_button.value.to_string ();

            rgba_format_label.label = "rgba(%s, %s, %s, %s)".printf(r, g, b, a);

            color_button.set_color (hex_main);
        }
    }
}
