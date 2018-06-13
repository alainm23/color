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
    public class Dialogs.Preferences : Gtk.Dialog {
        public MainWindow window { get; construct; }
        private Gtk.Switch dark_theme_switch;
        
        public Preferences () {
            title = _("Preferences");
            border_width = 12;
            deletable = true;
            resizable = false;
            transient_for = window;

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.expand = true;
            main_grid.height_request = 50;
            main_grid.width_request = 200;

            var dark_mode_label = new Granite.HeaderLabel (_("Dark Mode"));
            
            dark_theme_switch = new Gtk.Switch ();
            dark_theme_switch.valign = Gtk.Align.CENTER;

            var dark_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            dark_box.hexpand = true;
            dark_box.pack_start (dark_mode_label, false, false, 0);
            dark_box.pack_end (dark_theme_switch, false, false, 0);

            main_grid.add (dark_box);
            
            get_content_area ().add (main_grid);
        }
    }
}