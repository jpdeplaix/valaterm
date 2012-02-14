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

public class Terminal : Vte.Terminal
{
	private GLib.Pid? child_pid = null;

#if VTE_SUP_0_26 && VALAC_SUP_0_12_1
	private unowned string shell = Terminal.get_shell();
#endif

	public signal void title_changed(string title);

	public Terminal()
	{
		this.scroll_on_keystroke = true;

		this.background_transparent = Settings.transparency;
		this.scrollback_lines = Settings.scrollback_lines;
		this.set_font_from_string(Settings.font);
		this.set_colors(Settings.foreground_color,
						Settings.background_color,
						Colors.colors_palette);

		this.active_signals();
	}

	private void active_signals()
	{
		this.window_title_changed.connect(() => this.title_changed(this.window_title));
	}

	public void active_shell(string dir)
	{
// This part can only be compiled by valac >= 0.12.1 (see commit: c677)
#if VTE_SUP_0_26 && VALAC_SUP_0_12_1
		try
		{
			string[] args = {};

			GLib.Shell.parse_argv(this.shell, out args);
			this.fork_command_full(Vte.PtyFlags.DEFAULT, dir, args, null, GLib.SpawnFlags.SEARCH_PATH, null, out this.child_pid);
		}
		catch(GLib.Error error)
		{
			// Do something !
		}
#else
		this.child_pid = this.fork_command(null, null, null, dir, true, true, true);
#endif
	}

	public int calcul_width(int current_width, int column_count)
	{
		Gtk.Allocation? alloc = null;
		this.get_allocation(out alloc);

		int diff = current_width - ((!)(alloc)).width;
		int real_char_width = ((!)(alloc)).width / (int)(this.get_column_count());
		int diff_char = real_char_width - (int)(this.get_char_width());

		return (int)(this.get_char_width() * column_count) + diff + diff_char;
	}

	public int calcul_height(int current_height, int row_count)
	{
		Gtk.Allocation? alloc = null;
		this.get_allocation(out alloc);

		int diff = current_height - ((!)(alloc)).height;
		int real_char_height = ((!)(alloc)).height / (int)(this.get_row_count());
		int diff_char = real_char_height - (int)(this.get_char_height());

		return (int)(this.get_char_height() * row_count) + diff + diff_char;
	}

	public bool has_foreground_process()
	{
#if GTK3
		int pty = this.pty_object.fd;
#else
		int pty = this.pty;
#endif
		int fgpid = Posix.tcgetpgrp(pty);
		return fgpid != this.child_pid && fgpid != -1;
	}

#if VTE_SUP_0_26 && VALAC_SUP_0_12_1
	private static unowned string get_shell()
	{
		unowned string? shell = GLib.Environment.get_variable("SHELL");

		if(shell == null)
		{
			shell = "/bin/sh";
		}

		return (!)(shell);
	}
#endif

	//FIXME: Is it portable ?
	public string? get_shell_cwd()
	{
		int pid = (!)(this.child_pid);

		try
		{
			return GLib.FileUtils.read_link("/proc/%d/cwd".printf(pid));
		}
		catch(GLib.FileError error)
		{
#if DEBUG
			GLib.stderr.printf("Error: %s.\n", error.message);
#endif
		}

		return null;
	}
}