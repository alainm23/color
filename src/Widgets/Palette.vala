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
    public class Widgets.Palette : Gtk.Grid {
        private Gtk.Entry color_entry;
        private Gtk.Label second_label;
        private int index;
        private const string STYLE_CSS = """
                .%s {
                    background: %s;
                    color: white;
                }
            """;

        public Palette (int i) {
            index = i;
            get_style_context ().add_class (index.to_string ());
            orientation = Gtk.Orientation.VERTICAL;
            //margin = 6;
            expand = true;

            color_entry = new Gtk.Entry ();
            color_entry.text = "#7a36b1";
            color_entry.max_length = 7;
            color_entry.expand = true;
            color_entry.valign = Gtk.Align.END;
            color_entry.halign = Gtk.Align.END;
            //color_entry.xalign = 0.5;
            color_entry.get_style_context ().remove_class (Gtk.STYLE_CLASS_ENTRY);
            color_entry.get_style_context ().add_class ("h1");

            second_label = new Gtk.Label ("RGB(255, 25, 1)");
            second_label.margin_bottom = 24;
            second_label.get_style_context ().add_class ("h3");

            color_entry.changed.connect (() => {
                add_styles (color_entry.text);
            });

            add (color_entry);
            add (second_label);

            add_styles (color_entry.text);
        }

        private void add_styles (string color_hex) {
            var provider = new Gtk.CssProvider ();
            try {
                var colored_css = STYLE_CSS.printf (index.to_string (), color_hex);
                provider.load_from_data (colored_css, colored_css.length);
                
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                return;
            }
        }
    }
}