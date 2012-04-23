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

public class Accel : GLib.Object
{
    public uint key { get; private set; }
    public Gdk.ModifierType mods { get; private set; }
    public string accel { get; private set; }

    public Accel(string accel)
    {
        uint key = 0;
        Gdk.ModifierType mods = 0;

        this.accel = accel;
        Gtk.accelerator_parse(accel, out key, out mods);
        this.key = key;
        this.mods = mods;
    }
}
