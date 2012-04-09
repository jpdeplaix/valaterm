/****************************
** Copyright © 2011 Jacques-Pascal Deplaix
**
** ValaTerm is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <http://www.gnu.org/licenses/>.
****************************/

public class ShortcutsManager : DefaultDialog
{
    private ShortcutBox[] shortcuts = new ShortcutBox[0];

    public ShortcutsManager(MainWindow parent_window, ImageMenuItem[] items)
    {
        this.title = tr("ValaTerm shortcuts");
        this.transient_for = parent_window;

        var main_box = (Gtk.Box)(this.get_content_area());

        foreach(var item in items)
        {
            var shortcut = item.get_shortcut_box();

            main_box.pack_start(shortcut);
            this.shortcuts += shortcut;
        }
    }

    protected override void ok_clicked()
    {
        foreach(var box in this.shortcuts)
        {
            var key = box.get_accel_key();

            if(key != 0)
            {
                box.changed(key, box.get_accel_mods());
            }
        }
    }
}
