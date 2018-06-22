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
    private Widgets.FormatButton add_color_button;

    public class Widgets.ActionBar : Gtk.ActionBar {
        public ActionBar () {
            get_style_context ().add_class (Gtk.STYLE_CLASS_INLINE_TOOLBAR);
            height_request = 38;

            build_ui ();
        }

        private void build_ui () {
            add_color_button = new Widgets.FormatButton ();
            add_color_button.icon = new ThemedIcon ("list-add-symbolic");
            add_color_button.text = _("New Color");
            add_color_button.margin_left = 12;

            pack_start (add_color_button);
        }
    }
}