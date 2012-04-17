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
    private Gtk.Label label;
#if GTK3
    private Gtk.ComboBoxText first_key = new Gtk.ComboBoxText();
    private Gtk.ComboBoxText second_key = new Gtk.ComboBoxText();
#else
    private Gtk.ComboBox first_key = new Gtk.ComboBox.text();
    private Gtk.ComboBox second_key = new Gtk.ComboBox.text();
#endif
    private Gtk.Entry entry = new Gtk.Entry();

    public signal void changed(uint accel_key, Gdk.ModifierType accel_mods);

    public ShortcutBox(string label, string stock_id)
    {
        this.homogeneous = true;
        this.spacing = 10;
        this.label = new Gtk.Label(label + ":");

        this.first_key.append_text("Ctrl");
        this.first_key.append_text("Super");
        this.second_key.append_text("Shift");
        this.second_key.append_text("Alt");

        this.first_key.active = 0;
        this.init_combobox(stock_id);
        this.init_entry(stock_id);

        this.pack_start(this.label);
        this.pack_start(this.first_key);
        this.pack_start(this.second_key);
        this.pack_start(this.entry);
    }

    private void init_combobox(string label)
    {
        Gdk.ModifierType mods = Settings.get_accel_mods(label);

        if((Gdk.ModifierType.CONTROL_MASK & mods) != 0)
        {
            this.first_key.active = 0;
        }
        else if((Gdk.ModifierType.SUPER_MASK & mods) != 0)
        {
            this.first_key.active = 1;
        }

        if((Gdk.ModifierType.SHIFT_MASK & mods) != 0)
        {
            this.second_key.active = 0;
        }
        else if((Gdk.ModifierType.META_MASK & mods) != 0)
        {
            this.second_key.active = 1;
        }
    }

    private void init_entry(string label)
    {
        uint key = Settings.get_accel_key(label);

        if(key != 0)
        {
            this.entry.text = Gdk.keyval_name(key);
        }
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
