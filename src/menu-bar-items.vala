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

public class MenuBarItems : MenuItems
{
    private ImageMenuItem _about = new ImageMenuItem(Icons.ABOUT);
    private ImageMenuItem _quit = new ImageMenuItem(Icons.QUIT);
    private ImageMenuItem _shortcuts_manager = new ImageMenuItem(
        Icons.PREFERENCES, tr("Shortcuts Manager"));

    public ImageMenuItem about
    {
        get { return this._about; }
    }
    public ImageMenuItem quit
    {
        get { return this._quit; }
    }
    public ImageMenuItem shortcuts_manager
    {
        get { return this._shortcuts_manager; }
    }

    public ImageMenuItem[] get_items()
    {
        return new ImageMenuItem[] {
            this._preferences,
            this._clear,
            this._copy,
            this._paste,
            this._select_all,
            this._new_window,
            this._about,
            this._quit,
            this._shortcuts_manager
        };
    }

    public async void set_accel(Gtk.AccelGroup accel)
    {
        Idle.add(this.set_accel.callback);
        yield;

        var items = this.get_items();

        foreach(var item in items)
        {
            Idle.add(this.set_accel.callback);
            yield;

            item.set_accel(accel);
        }
    }
}
