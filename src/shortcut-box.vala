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

public class ShortcutBox : Gtk.HBox
{
	Gtk.ComboBox first_key = new Gtk.ComboBox.text();
	Gtk.ComboBox second_key = new Gtk.ComboBox.text();
	Gtk.Entry entry = new Gtk.Entry();

	public ShortcutBox()
	{
		this.first_key.append_text("Ctrl");
		this.first_key.append_text("Super");
		this.second_key.append_text("Shift");
		this.second_key.append_text("Alt");

		this.first_key.active = 0;

		this.pack_start(this.first_key);
		this.pack_start(this.second_key);
		this.pack_start(this.entry);
	}

	public uint get_accel_key()
	{
		return Gdk.keyval_from_name(this.entry.text);
	}

	public Gdk.ModifierType get_accel_mods()
	{
		Gdk.ModifierType mods = 0;

		switch(this.first_key.get_active_text())
		{
		case "Ctrl":
			mods |= Gdk.ModifierType.CONTROL_MASK;
			break;
		case "Super":
			mods |= Gdk.ModifierType.SUPER_MASK;
			break;
		}

		switch(this.second_key.get_active_text())
		{
		case "Shift":
			mods |= Gdk.ModifierType.SHIFT_MASK;
			break;
		case "Alt":
			mods |= Gdk.ModifierType.META_MASK;
			break;
		}

		return mods;
	}
}