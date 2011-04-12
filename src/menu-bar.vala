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
	private Gtk.ImageMenuItem item_about = new Gtk.ImageMenuItem.from_stock(Gtk.Stock.ABOUT, null);
	private Gtk.MenuItem item_preferences = new Gtk.MenuItem.with_label("Preferences");
	private Gtk.MenuItem item_clear = new Gtk.MenuItem.with_label("Clear");
	private Gtk.AccelGroup accel_group = new Gtk.AccelGroup();

	public Menubar()
	{
		this.item_about.label = "About";
		this.item_about.accel_group = this.accel_group;

		var menu_edit = new Gtk.MenuItem.with_label("Edit");
		var submenu_edit = new Gtk.Menu();
		menu_edit.set_submenu(submenu_edit);
		submenu_edit.append(this.item_preferences);

		var menu_tools = new Gtk.MenuItem.with_label("Tools");
		var submenu_tools = new Gtk.Menu();
		menu_tools.set_submenu(submenu_tools);
		submenu_tools.append(this.item_clear);

		var menu_help = new Gtk.MenuItem.with_label("Help");
		var submenu_help = new Gtk.Menu();
		menu_help.set_submenu(submenu_help);
		submenu_help.append(this.item_about);

		this.append(menu_edit);
		this.append(menu_tools);
		this.append(menu_help);
	}

	public void active_signals(Delegates.AccelGroup add_accel_group,
							   Delegates.Void about,
							   Delegates.Void preferences,
							   Delegates.Void clear)
	{
		add_accel_group(this.accel_group);

		this.item_about.activate.connect(() => about());
		this.item_preferences.activate.connect(() => preferences());
		this.item_clear.activate.connect(() => clear());
	}
}