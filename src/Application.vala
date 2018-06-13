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
    public class ColorView : Gtk.Application {
        public ColorView () {
            Object (
                application_id: "com.github.alainm23.color",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {

            var app_window = new MainWindow (this);
            app_window.show_all ();

            var quit_action = new SimpleAction ("quit", null);

            add_action (quit_action);
            add_accelerator ("<Control>q", "app.quit", null);

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/alainm23/color/stylesheet.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            quit_action.activate.connect (() => {
                if (app_window != null) {
                    app_window.destroy ();
                }
            });
        }


        private static int main (string[] args) {
            Gtk.init (ref args);

            var app = new ColorView ();
            return app.run (args);
        }
    }
}
