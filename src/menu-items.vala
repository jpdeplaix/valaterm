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

public class MenuItems : GLib.Object
{
    protected ImageMenuItem _preferences = new ImageMenuItem(Icons.PREFERENCES);
    protected ImageMenuItem _clear = new ImageMenuItem(Icons.CLEAR);
    protected ImageMenuItem _copy = new ImageMenuItem(Icons.COPY);
    protected ImageMenuItem _paste = new ImageMenuItem(Icons.PASTE);
    protected ImageMenuItem _select_all = new ImageMenuItem(Icons.SELECT_ALL);
    protected ImageMenuItem _new_window = new ImageMenuItem(Icons.NEW, tr("New Window"));

    public ImageMenuItem preferences
    {
        get { return this._preferences; }
    }
    public ImageMenuItem clear
    {
        get { return this._clear; }
    }
    public ImageMenuItem copy
    {
        get { return this._copy; }
    }
    public ImageMenuItem paste
    {
        get { return this._paste; }
    }
    public ImageMenuItem select_all
    {
        get { return this._select_all; }
    }
    public ImageMenuItem new_window
    {
        get { return this._new_window; }
    }
}