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

public class Menubar : Gtk.MenuBar
{
    public Menubar(MenuBarItems items)
    {
        var menu_file = new MenuItem(tr("File"), {
                items.new_window,
                new Gtk.SeparatorMenuItem(),
                items.quit
            });

        var menu_edit = new MenuItem(tr("Edit"), {
                items.copy,
                items.paste,
                new Gtk.SeparatorMenuItem(),
                items.select_all,
                new Gtk.SeparatorMenuItem(),
                items.preferences
            });

        var menu_tools = new MenuItem(tr("Tools"), {
                items.shortcuts_manager,
                items.clear
            });

        var menu_help = new MenuItem(tr("Help"), {
                items.about
            });

        this.append(menu_file);
        this.append(menu_edit);
        this.append(menu_tools);
        this.append(menu_help);
    }

    public override void show()
    {
        if(Settings.show_menubar)
        {
            base.show();
        }
    }
}
