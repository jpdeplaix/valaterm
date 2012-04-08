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

public class MainWindow : Gtk.Window
{
	private static uint window_count = 0;

	public Menubar menubar = new Menubar();
	private Terminal terminal = new Terminal();
	private Gtk.ScrolledWindow scrolled_window = new Gtk.ScrolledWindow(null, null);
	public Gtk.AccelGroup accel_group = new Gtk.AccelGroup();

	public MainWindow()
	{
		// FIXME: The window title keep this title instead of the shell title.
		this.title = "ValaTerm";
		this.icon = new Gdk.Pixbuf.from_xpm_data(Pictures.logo);

		this.window_count++;

		this.show_scrollbar(Settings.show_scrollbar);
		this.scrolled_window.add(this.terminal);

		var main_box = new Gtk.VBox(false, 0);
		main_box.pack_start(this.menubar, false);
		main_box.pack_start(this.scrolled_window);

		this.add_accel_group(this.accel_group);
        this.menubar.set_accel(this.accel_group);

		this.active_signals();
		this.add(main_box);
	}

	public void display(string shell_cwd = GLib.Environment.get_home_dir())
	{
		this.show_all();

		this.resize(this.terminal.calcul_width(80),
					this.terminal.calcul_height(24));

		// Do that after resize because Vte add rows if the main window is too small...
		this.terminal.active_shell(shell_cwd);
	}

	private void active_signals()
	{
		this.menubar.about.connect(() => About.display(this));
		this.menubar.preferences.connect(() =>
		{
			var dialog = new ParametersWindow(this);
			dialog.font_changed.connect(this.terminal.set_font_from_string);
			dialog.background_color_changed.connect(this.terminal.set_color_background);
			dialog.foreground_color_changed.connect(this.terminal.set_color_foreground);
			dialog.scrollback_lines_changed.connect(this.terminal.set_scrollback_lines);
			dialog.transparency_changed.connect(this.terminal.set_background_transparent);
			dialog.show_scrollbar_changed.connect(this.show_scrollbar);
			dialog.show_all();
		});
		this.menubar.clear.connect(() => this.terminal.reset(true, true));
		this.menubar.copy.connect(() => { stdout.printf("COUCOU\n"); this.terminal.copy_clipboard(); });
		this.menubar.paste.connect(() => this.terminal.paste_clipboard());
		this.menubar.select_all.connect(() => this.terminal.select_all());
		this.menubar.new_window.connect(this.new_window);
		this.menubar.quit.connect(this.exit);
		this.menubar.shortcuts_manager.connect(() => {
				var dialog = new ShortcutsManager(this);
				dialog.show_all();
			});

		this.delete_event.connect(this.on_delete);
		this.destroy.connect(this.on_destroy);
		this.terminal.child_exited.connect(this.exit);

		this.terminal.title_changed.connect(this.set_title);
		this.terminal.new_window.connect(this.new_window);
		this.terminal.display_menubar.connect(this.menubar.set_visible);
	}

	private void on_destroy()
	{
		if(this.window_count < 2)
		{
			Gtk.main_quit();
		}
		else
		{
			this.window_count--;
		}
	}

	private void exit()
	{
		if(this.on_delete() == false)
		{
			this.destroy();
		}
	}

	private bool on_delete()
	{
		bool return_value = false;

		if(this.terminal.has_foreground_process())
		{
			var dialog = new MessageDialog(this, tr("There is still a process running in this terminal. Closing the window will kill it."), tr("Would you closing this window ?"));

			if(dialog.run() == Gtk.ResponseType.CANCEL)
			{
				return_value = true;
			}

			dialog.destroy();
		}

		return return_value;
	}

	private void new_window()
	{
		var window = new MainWindow();
		window.display(this.terminal.get_shell_cwd());
	}

	private void show_scrollbar(bool show)
	{
		if(show == true)
			this.scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
		else
			this.scrolled_window.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.NEVER);
	}
}