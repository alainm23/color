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
    public class Widgets.FormatButton : Gtk.Button {
        public unowned string text {
            set {
                label_widget.label = "<b>%s</b>".printf (value);
            }

            get {
                return label_widget.get_label ();
            }
        }

        public unowned GLib.Icon? icon {
            owned get {
                return img.gicon;
            }
            set {
                img.gicon = value;
            }
        }

        private Gtk.Image img;
        private Gtk.Label label_widget;

        construct {
            var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
    
            img = new Gtk.Image ();
            img.halign = Gtk.Align.END;
            img.icon_size = Gtk.IconSize.BUTTON;

            label_widget = new Gtk.Label (null);
            label_widget.use_markup = true;
            label_widget.halign = Gtk.Align.START;

            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            valign = Gtk.Align.CENTER;

            main_box.pack_start (img, false, false, 0);
            main_box.pack_start (label_widget, false, false, 0);
            add (main_box);
        }
    }
}