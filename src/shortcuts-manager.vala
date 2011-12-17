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
	ShortcutBox copy_shortcut = new ShortcutBox();

	public ShortcutsManager(MainWindow parent_window)
	{
		this.title = tr("ValaTerm shortcuts");
		this.transient_for = parent_window;

		var main_box = (Gtk.Box)(this.get_content_area());
		main_box.pack_start(this.copy_shortcut);
	}

	protected override void ok_clicked()
	{
	}
}