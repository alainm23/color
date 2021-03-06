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
    public class Widgets.Headerbar : Gtk.HeaderBar {
        private Dialogs.Preferences preferences_dialog;
        private Gtk.Button app_menu;
        private Gtk.Button back_button;
        private Gtk.Button next_button;
        private Widgets.PaletteButton palette_button;
        private Widgets.Popovers.Palette palette_popover;


        public Headerbar () {
            set_show_close_button (true);
            get_style_context ().add_class ("compact");

            build_ui ();
        }

        private void build_ui () {
            //back_button = new Gtk.Button.from_icon_name ("document-revert", Gtk.IconSize.LARGE_TOOLBAR);
            //next_button = new Gtk.Button.from_icon_name ("document-revert-rtl", Gtk.IconSize.LARGE_TOOLBAR);
            
            app_menu = new Gtk.Button.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            app_menu.tooltip_text = _("Preferences");
            app_menu.sensitive = true;

            app_menu.clicked.connect (() => {
                preferences_dialog = new Dialogs.Preferences ();
                preferences_dialog.destroy.connect (Gtk.main_quit);
                preferences_dialog.show_all ();
            });

            palette_button = new Widgets.PaletteButton ();
            palette_popover = new Widgets.Popovers.Palette (palette_button);
            
            palette_button.clicked.connect (() => {
                palette_popover.show_all ();

            });
            
            //pack_start (back_button);
            //pack_start (next_button);

            set_custom_title (palette_button);
            pack_end (app_menu);
        }
    }
}