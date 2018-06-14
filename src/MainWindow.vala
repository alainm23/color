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

namespace Color {
    public class MainWindow : Gtk.Window {
        private Widgets.Headerbar headerbar;
        private Services.Settings settings;

        private Widgets.Palette palette_01;
        private Widgets.Palette palette_02;
        private Widgets.Palette palette_03;
        private Widgets.Palette palette_04; 
        private Widgets.Palette palette_05;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                icon_name: "com.github.alainm23.color",
                width_request: 500,
                height_request: 600,
                title: _("Color"),
                window_position: Gtk.WindowPosition.CENTER
            );


            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/com/github/alainm23/color");

            //Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;

            settings = new Services.Settings ();
            var window_x = settings.window_x;
            var window_y = settings.window_y;
            move (window_x, window_y);

            var window_width = settings.window_width;
            var window_height = settings.window_height;
            set_default_size (window_width, window_height);
    
            build_ui ();
            
            // Event to save x, y, width height
            this.delete_event.connect (() => {
                int current_x, current_y, width, height;
                get_position (out current_x, out current_y);
                get_size (out width, out height);

                settings.window_width = width;
                settings.window_height = height;
                settings.window_x = current_x;
                settings.window_y = current_y;

                return false;
            });
        }

        private void build_ui () {
            headerbar = new Widgets.Headerbar ();

            palette_01 = new Widgets.Palette (1);
            palette_02 = new Widgets.Palette (2);
            palette_03 = new Widgets.Palette (3);
            palette_04 = new Widgets.Palette (4);
            palette_05 = new Widgets.Palette (5);

            var main_grid = new Gtk.Grid ();
            main_grid.expand = true;
            main_grid.column_homogeneous = true;

            main_grid.add (palette_01);
            main_grid.add (palette_02);
            main_grid.add (palette_03);
            main_grid.add (palette_04);
            main_grid.add (palette_05);
        
            add (main_grid);
            set_titlebar (headerbar);
            show_all ();
        }

        /*
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
        */
    }
}
