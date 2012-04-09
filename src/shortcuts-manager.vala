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
	private ShortcutBox about_shortcut = new ShortcutBox();
	private ShortcutBox preferences_shortcut = new ShortcutBox();
	private ShortcutBox clear_shortcut = new ShortcutBox();
	private ShortcutBox copy_shortcut = new ShortcutBox();
	private ShortcutBox paste_shortcut = new ShortcutBox();
	private ShortcutBox select_all_shortcut = new ShortcutBox();
	private ShortcutBox new_window_shortcut = new ShortcutBox();
	private ShortcutBox quit_shortcut = new ShortcutBox();
	private ShortcutBox shortcuts_manager_shortcut = new ShortcutBox();

    public signal void about_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void preferences_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void clear_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void copy_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void paste_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void select_all_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void new_window_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void quit_changed(uint accel_key, Gdk.ModifierType accel_mods);
    public signal void shortcuts_manager_changed(uint accel_key, Gdk.ModifierType accel_mods);

	public ShortcutsManager(MainWindow parent_window)
	{
		this.title = tr("ValaTerm shortcuts");
		this.transient_for = parent_window;

		var main_box = (Gtk.Box)(this.get_content_area());
		main_box.pack_start(this.about_shortcut);
		main_box.pack_start(this.preferences_shortcut);
		main_box.pack_start(this.clear_shortcut);
		main_box.pack_start(this.copy_shortcut);
		main_box.pack_start(this.paste_shortcut);
		main_box.pack_start(this.select_all_shortcut);
		main_box.pack_start(this.new_window_shortcut);
		main_box.pack_start(this.quit_shortcut);
		main_box.pack_start(this.shortcuts_manager_shortcut);
	}

	protected override void ok_clicked()
	{
        var about_key = this.about_shortcut.get_accel_key();
        var preferences_key = this.preferences_shortcut.get_accel_key();
        var clear_key = this.clear_shortcut.get_accel_key();
        var copy_key = this.copy_shortcut.get_accel_key();
        var paste_key = this.paste_shortcut.get_accel_key();
        var select_all_key = this.select_all_shortcut.get_accel_key();
        var new_window_key = this.new_window_shortcut.get_accel_key();
        var quit_key = this.quit_shortcut.get_accel_key();
        var shortcuts_manager_key = this.shortcuts_manager_shortcut.get_accel_key();

        if(about_key != 0)
        {
            this.about_changed(about_key, this.about_shortcut.get_accel_mods());
        }
        if(preferences_key != 0)
        {
            this.preferences_changed(preferences_key, this.preferences_shortcut.get_accel_mods());
        }
        if(clear_key != 0)
        {
            this.clear_changed(clear_key, this.clear_shortcut.get_accel_mods());
        }
        if(copy_key != 0)
        {
            this.copy_changed(copy_key, this.copy_shortcut.get_accel_mods());
        }
        if(paste_key != 0)
        {
            this.paste_changed(paste_key, this.paste_shortcut.get_accel_mods());
        }
        if(select_all_key != 0)
        {
            this.select_all_changed(select_all_key, this.select_all_shortcut.get_accel_mods());
        }
        if(new_window_key != 0)
        {
            this.new_window_changed(new_window_key, this.new_window_shortcut.get_accel_mods());
        }
        if(quit_key != 0)
        {
            this.quit_changed(quit_key, this.quit_shortcut.get_accel_mods());
        }
        if(shortcuts_manager_key != 0)
        {
            this.shortcuts_manager_changed(shortcuts_manager_key, this.shortcuts_manager_shortcut.get_accel_mods());
        }
	}
}