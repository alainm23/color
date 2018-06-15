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
    public class Widgets.Palette : Gtk.EventBox {
        private Gtk.Entry color_entry;
        private Gtk.Label second_label;
        private Widgets.Popovers.Color color_popover;
        private int index;
        private bool edit = false;
        private const string STYLE_CSS = """
                .%s {
                    background: %s;
                    color: %s;
                    border-radius: 5px;
                }
            """;
        private const string BUTTON_CSS = """
            .button-%s {
                color: %s;
            }
            """;
        
        public Palette (int i) {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.row_spacing = 12;
            main_grid.expand = true;

            margin_left = 6;
            margin_top = 6;
            margin_bottom = 6;

            index = i;
            get_style_context ().add_class (index.to_string ());
            
            var adjust_button = new Gtk.ToggleButton ();
            adjust_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
            adjust_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            adjust_button.vexpand = true;
            adjust_button.margin_top = 24;
            adjust_button.valign = Gtk.Align.START;
            adjust_button.halign = Gtk.Align.CENTER;
            adjust_button.get_style_context ().add_class ("button-" + index.to_string ());

            color_popover = new Widgets.Popovers.Color (adjust_button);

            var adjust_revealer = new Gtk.Revealer ();
            adjust_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            adjust_revealer.add (adjust_button);
            adjust_revealer.reveal_child = false;

            color_entry = new Gtk.Entry ();
            color_entry.placeholder_text = "#363B3E";
            color_entry.max_length = 7;
            color_entry.expand = true;
            color_entry.valign = Gtk.Align.END;
            color_entry.xalign = 0.5f;
            color_entry.get_style_context ().remove_class (Gtk.STYLE_CLASS_ENTRY);
            color_entry.get_style_context ().add_class ("h1");

            second_label = new Gtk.Label (null);
            second_label.margin_bottom = 24;
            second_label.selectable = true;
            second_label.use_markup = true;
            second_label.get_style_context ().add_class ("h3");

            color_entry.changed.connect (() => {
                add_styles (color_entry.text);
                second_label.label = convert_rgb (color_entry.text);
            });

            main_grid.add (adjust_revealer);
            main_grid.add (color_entry);
            main_grid.add (second_label);

            add (main_grid);

            add_styles (color_entry.text);
            second_label.label = convert_rgb ("#363B3E");

            this.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK | Gdk.EventMask.LEAVE_NOTIFY_MASK);
            this.enter_notify_event.connect ((event) => {
                if (edit != true) {
                    adjust_revealer.reveal_child = true;
                }

                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }

                if (edit != true) {
                    adjust_revealer.reveal_child = false;
                }

                return false;
            });

            adjust_button.toggled.connect (() => {
                if (adjust_button.active) {
                    edit = true;
                    color_popover.show_all ();
                }
            });

            color_popover.closed.connect (() => {
                adjust_button.active = false;
                edit = false;
                adjust_revealer.reveal_child = false; 
            });
        }

        private string convert_rgb (string color_hex) {
            Gdk.RGBA color = Gdk.RGBA ();
            color.parse (color_hex);

            string color_rgb = "<b>rgb(%s, %s, %s)</b>".printf (
                (color.red * 255).to_string (), 
                (color.green * 255).to_string (), 
                (color.blue * 255).to_string ()
            ); 

            return color_rgb;
        }

        private string convert_invert (string color_hex) {
            Gdk.RGBA color = Gdk.RGBA ();
            color.parse (color_hex);

            var r = 255 - (color.red * 255);
            var g = 255 - (color.green * 255);
            var b = 255 - (color.blue * 255);

            string hex = "#%02x%02x%02x"
                .printf((uint) (r),
                (uint) (g),
                (uint) (b)
            );

            return hex;
        }

        private void add_styles (string color_hex) {
            var provider = new Gtk.CssProvider ();
            try {
                var colored_css = STYLE_CSS.printf (
                    index.to_string (),         // Class Name
                    color_hex,                  // Background Color
                    convert_invert (color_hex)  // Text Color Invert
                );
                provider.load_from_data (colored_css, colored_css.length);
                
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                return;
            }

            var provider_button = new Gtk.CssProvider ();
            try {
                var buttton_css = BUTTON_CSS.printf (
                    index.to_string (),
                    convert_invert (color_hex)  
                );
                provider_button.load_from_data (buttton_css, buttton_css.length);

                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider_button, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                return;
            }

        }
    }
}