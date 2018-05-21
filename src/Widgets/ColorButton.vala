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
    public class Widgets.ColorButton : Gtk.ToggleButton {
        private const string BUTTON_CSS = """
            .color {
                background: %s;
            }
        """;

        public ColorButton () {
            Object (
                height_request: 150,
                width_request: 150,
                hexpand: true,
                tooltip_text: _("Color Preview"),
                hexpand: true,
                halign: Gtk.Align.CENTER
            );
        }

        construct {
            get_style_context ().add_class ("border");
            get_style_context ().add_class ("color");
        }

        public void set_color (string hex_color) {
            var provider = new Gtk.CssProvider ();
            try {
                var colored_css = BUTTON_CSS.printf (hex_color);
                provider.load_from_data (colored_css, colored_css.length);

                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                return;
            }
        }
    }
}
