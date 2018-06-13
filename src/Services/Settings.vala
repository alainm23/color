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
    public class Services.Settings : Granite.Services.Settings {
        public int window_width { get; set; }
        public int window_height { get; set; }
        public int window_x { get; set; }
        public int window_y { get; set; }
        public bool dark { get; set; }

        public Settings () {
            base ("com.github.alainm23.color");
        }
    }
}