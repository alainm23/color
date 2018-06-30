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
        private Widgets.ActionBar action_bar;
        private Services.Settings settings;

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

            settings = new Services.Settings ();
            var window_x = settings.window_x;
            var window_y = settings.window_y;
            move (window_x, window_y);

            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = settings.dark;

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
            //get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);

            headerbar = new Widgets.Headerbar ();
            set_titlebar (headerbar);

            action_bar = new Widgets.ActionBar ();

            var flow_box = new Gtk.FlowBox ();
            flow_box.selection_mode = Gtk.SelectionMode.NONE;
            flow_box.max_children_per_line = 5;
            flow_box.expand = true;
            flow_box.margin = 24;
            flow_box.row_spacing = 24;
            flow_box.column_spacing = 24;
            flow_box.homogeneous = true;
            flow_box.valign = Gtk.Align.START;
            flow_box.halign = Gtk.Align.START;

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
            scrolled.add (flow_box);

            flow_box.add (new Widgets.Color(1));
            
            flow_box.add (new Widgets.Color(2));
            flow_box.add (new Widgets.Color(3));
            
            flow_box.add (new Widgets.Color(4));
            flow_box.add (new Widgets.Color(5));
            
            flow_box.add (new Widgets.Color(6));
            flow_box.add (new Widgets.Color(9));
            flow_box.add (new Widgets.Color(10));
            flow_box.add (new Widgets.Color(11));
            flow_box.add (new Widgets.Color(12));
            flow_box.add (new Widgets.Color(13));
            flow_box.add (new Widgets.Color(14));
            flow_box.add (new Widgets.Color(15));
            
            flow_box.add (new Widgets.Color(16));
            flow_box.add (new Widgets.Color(17));
            flow_box.add (new Widgets.Color(18));
            flow_box.add (new Widgets.Color(19));
            flow_box.add (new Widgets.Color(20));
            flow_box.add (new Widgets.Color(21));
            flow_box.add (new Widgets.Color(22));
            flow_box.add (new Widgets.Color(23));
            flow_box.add (new Widgets.Color(24));
            flow_box.add (new Widgets.Color(25));
            
            var action_bar = new Widgets.ActionBar ();

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.expand = true;

            main_grid.add (scrolled);
            main_grid.add (action_bar);

            add (main_grid);
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
