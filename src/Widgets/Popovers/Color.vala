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
    public class Widgets.Popovers.Color : Gtk.Popover {
        private Gtk.Stack main_stack;
        private Granite.Widgets.ModeButton mode_button;

        public Color (Gtk.Widget relative) {
            relative_to = relative;
            modal = true;
            position = Gtk.PositionType.LEFT;
            
            height_request = 300;
            width_request = 300;

            build_ui ();
        }

        private void build_ui () {
            mode_button = new Granite.Widgets.ModeButton ();
            mode_button.append_text ("HSB");
            mode_button.append_text ("RGB");
            mode_button.append_text ("CMYK");
            mode_button.selected = 0;

            main_stack = new Gtk.Stack ();
            main_stack.expand = true;
            main_stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.margin = 6;
            main_grid.expand = true;

            main_grid.add (mode_button);
            main_grid.add (main_stack);
            
            add (main_grid);
        }
    }
}