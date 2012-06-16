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

public class ImageMenuItem : Gtk.ImageMenuItem
{
    private ShortcutBox shortcut;
    private unowned Gtk.AccelGroup group;
    private Accel accel = new Accel("");
    private string stock_id;
    private bool have_custom_label = false;

    public ImageMenuItem(string stock_id, string? label = null)
    {
        this.label = stock_id;
        this.use_stock = true;
        this.stock_id = stock_id;

        if(label != null)
        {
            this.label = (!)(label);
            this.have_custom_label = true;
            this.stock_id = (!)(label);
        }
    }

    public ShortcutBox get_shortcut_box()
    {
        if(this.have_custom_label)
        {
            this.shortcut = new ShortcutBox(this.label, this.stock_id);
        }
        else
        {
            Gtk.StockItem item;

            Gtk.Stock.lookup(this.stock_id, out item);
            this.shortcut = new ShortcutBox(item.label.replace("_", ""),
                                            this.stock_id);
        }

        this.shortcut.changed.connect(this.set_accelerator);

        return this.shortcut;
    }

    public void set_accel(Gtk.AccelGroup group)
    {
        this.group = group;
        this.init_accelerator();
    }

    private void init_accelerator()
    {
        var accel = Settings.get_accel(this.stock_id);

        this.set_accelerator(accel);
    }

    private void set_accelerator(Accel accel)
    {
        if(this.accel.key != 0)
        {
            this.remove_accelerator(this.group, this.accel.key,
                                    this.accel.mods);
        }

        if(accel.key != 0)
        {
            this.add_accelerator("activate", this.group, accel.key, accel.mods,
                                 Gtk.AccelFlags.VISIBLE);
            this.accel_group = this.group;
        }

        this.accel = accel;
        Settings.set_accel(this.stock_id, this.accel);
    }
}
