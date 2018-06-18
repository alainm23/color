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
    public class Widgets.PaletteButton : Gtk.Button {
        private Gtk.Label name_label;
        private Gtk.Label description_label;
        private Gtk.Revealer description_revealer;
        private Gtk.Revealer name_revealer;

        public PaletteButton () {
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            get_style_context ().add_class ("palette-button");
            set_focus_on_click (false);

            build_ui ();
        }

        private void build_ui () {
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.valign = Gtk.Align.CENTER;
            
            name_label = new Gtk.Label ("elementary");
            name_label.use_markup = true;
            name_label.get_style_context ().add_class ("h4");

            name_revealer = new Gtk.Revealer ();
            name_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            name_revealer.add (name_label);
            name_revealer.reveal_child = true;

            description_label = new Gtk.Label ("Paleta oficial del proyecto elementary");
            description_label.use_markup = true;
            description_label.get_style_context ().add_class ("h4");

            description_revealer = new Gtk.Revealer ();
            description_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            description_revealer.add (description_label);
            description_revealer.reveal_child = false;

            this.enter_notify_event.connect ( (event) => {
                description_revealer.reveal_child = true;
                name_revealer.reveal_child = false;

                return false;
            });

            this.leave_notify_event.connect ((event) => {
                if (event.detail == Gdk.NotifyType.INFERIOR) {
                    return false;
                }
                
                description_revealer.reveal_child = false;
                name_revealer.reveal_child = true;
                
                return false;
            });

            var colors_box = new Gtk.Grid ();
            colors_box.halign = Gtk.Align.CENTER;
            colors_box.column_homogeneous = true;

            colors_box.get_style_context ().add_class (Granite.STYLE_CLASS_STORAGEBAR);

            var color_1 = new Gtk.Label (null);
            color_1.width_request = 30;
            color_1.get_style_context ().add_class ("block");
            color_1.get_style_context ().add_class ("tres");

            var color_2 = new Gtk.Label (null);
            color_2.get_style_context ().add_class ("block");
            color_2.get_style_context ().add_class ("dos");

            var color_3 = new Gtk.Label (null);
            color_3.get_style_context ().add_class ("block");
            color_3.get_style_context ().add_class ("tres");

            var color_4 = new Gtk.Label (null);
            color_4.get_style_context ().add_class ("block");
            color_4.get_style_context ().add_class ("cuatro");

            var color_5 = new Gtk.Label (null);
            color_5.get_style_context ().add_class ("block");
            color_5.get_style_context ().add_class ("cinco");

            colors_box.add (color_1);
            colors_box.add (color_2);
            colors_box.add (color_3);
            colors_box.add (color_4);
            colors_box.add (color_5);

            main_grid.attach (name_revealer, 0, 0, 1, 1);
            main_grid.attach (description_revealer, 0, 0, 1, 1);
            main_grid.attach (colors_box, 0, 1, 1, 1);

            add (main_grid);
        }
    }
}