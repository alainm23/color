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
    public class Widgets.Color : Gtk.EventBox {
        private Gtk.Entry color_entry;
        private Gtk.Label second_label;
        private Widgets.Popovers.Color color_popover;
        
        private Gtk.Button remove_button;
        private Gtk.Revealer remove_revealer;


        private int index;
        private bool edit = false;

        private const string STYLE_CSS = """
                .%s {
                    background: %s;
                    color: %s;
                }
            """;

        public Color (int i) {
            var main_box = new Gtk.Grid ();
            main_box.orientation = Gtk.Orientation.VERTICAL;
            main_box.expand = true;

            index = i;
            get_style_context ().add_class (Gtk.STYLE_CLASS_BUTTON);
            get_style_context ().add_class (index.to_string ());

            height_request = 115;
            width_request = 186;

            color_entry = new Gtk.Entry ();
            color_entry.placeholder_text = "#hexadecimal";
            color_entry.max_length = 7;
            color_entry.xalign = 0.5f;
            color_entry.margin_bottom = 6;
            color_entry.valign = Gtk.Align.END;
            color_entry.get_style_context ().remove_class (Gtk.STYLE_CLASS_ENTRY);
            color_entry.get_style_context ().add_class ("h3");

            second_label = new Gtk.Label (null);
            second_label.margin_bottom = 6;
            second_label.valign = Gtk.Align.END;
            second_label.selectable = true;
            second_label.use_markup = true;

            color_popover = new Widgets.Popovers.Color (this);

            var event_box = new Gtk.EventBox ();
            event_box.expand = true;
            event_box.add (new Gtk.Label (null));

            event_box.button_press_event.connect ((event) => {
                color_popover.show_all ();
                return false;
            });
        
            color_entry.changed.connect (() => {
                add_styles (color_entry.text);
                second_label.label = convert_rgb (color_entry.text);
            });
            
            main_box.add (event_box);
            main_box.add (color_entry);
            main_box.add (second_label);
            
            add (main_box);
            add_styles (color_entry.text);
            second_label.label = convert_rgb ("#fff");
        }

        private string convert_rgb (string color_hex) {
            Gdk.RGBA color = Gdk.RGBA ();
            color.parse (color_hex);

            string color_rgb = "rgb(%s, %s, %s)".printf (
                (color.red * 255).to_string (), 
                (color.green * 255).to_string (), 
                (color.blue * 255).to_string ()
            ); 

            return color_rgb;
        }

        private string convert_invert (string hex) {
            var gdk_white = Gdk.RGBA ();
            gdk_white.parse ("#fff");
    
            var gdk_black = Gdk.RGBA ();
            gdk_black.parse ("#000");
    
            var gdk_bg = Gdk.RGBA ();
            gdk_bg.parse (hex);
    
            var contrast_white = contrast_ratio (
                gdk_bg,
                gdk_white
            );
            var contrast_black = contrast_ratio (
                gdk_bg,
                gdk_black
            );
    
            var fg_color = "#fff";
            
            // NOTE: We cheat and add 3 to contrast when checking against black, 
            // because white generally looks better on a colored background
            if (contrast_black > (contrast_white + 3)) {
                fg_color = "#000";
            }

            return fg_color;
        }

        private double contrast_ratio (Gdk.RGBA bg_color, Gdk.RGBA fg_color) {
            var bg_luminance = get_luminance (bg_color);
            var fg_luminance = get_luminance (fg_color);
    
            if (bg_luminance > fg_luminance) {
                return (bg_luminance + 0.05) / (fg_luminance + 0.05);
            }
    
            return (fg_luminance + 0.05) / (bg_luminance + 0.05);
        }

        private double get_luminance (Gdk.RGBA color) {

            var red = sanitize_color (color.red) * 0.2126;
            var green = sanitize_color (color.green) * 0.7152;
            var blue = sanitize_color (color.blue) * 0.0722;
    
            return (red + green + blue);
        }
        
        private double sanitize_color (double color) {
            if (color <= 0.03928) {
                return color / 12.92;
            }
    
            return Math.pow ((color + 0.055) / 1.055, 2.4);
        }

        private void add_styles (string color_hex) {
            var provider = new Gtk.CssProvider ();
            
            try {
                var colored_css = STYLE_CSS.printf (
                    index.to_string (),         // Class Name
                    color_hex,                  // Background Color
                    convert_invert (color_hex)  // Text Color
                );
                provider.load_from_data (colored_css, colored_css.length);
                
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                return;
            }
        }
    }
}