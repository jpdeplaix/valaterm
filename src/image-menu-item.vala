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
    private unowned Gtk.AccelGroup? accel = null;
    private uint? accel_key = null;
    private Gdk.ModifierType? accel_mod = null;

	public ImageMenuItem(string image, string? label = null)
	{
		this.label = image;
		this.use_stock = true;

		if(label != null)
		{
			this.label = (!)(label);
		}
	}

    public void set_accel(Gtk.AccelGroup accel)
    {
        this.accel = accel;
    }

    public void set_accelerator(uint accel_key, Gdk.ModifierType accel_mod)
    {
        if(this.accel_key != null && this.accel_mod != null)
        {
            this.remove_accelerator(this.accel, this.accel_key, this.accel_mod);
        }
        this.add_accelerator("activate", this.accel, accel_key, accel_mod, Gtk.AccelFlags.VISIBLE);
        this.accel_group = this.accel;
        this.accel_key = accel_key;
        this.accel_mod = accel_mod;
    }
}