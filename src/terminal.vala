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
	private ContextMenu context_menu = new ContextMenu();

	public Terminal()
	{
		const Gdk.Color[] color =
		{
			{ 0, 0x2e2e, 0x3434, 0x3636 },
			{ 0, 0xcccc, 0x0000, 0x0000 },
			{ 0, 0x4e4e, 0x9a9a, 0x0606 },
			{ 0, 0xc4c4, 0xa0a0, 0x0000 },
			{ 0, 0x3434, 0x6565, 0xa4a4 },
			{ 0, 0x7575, 0x5050, 0x7b7b },
			{ 0, 0x0606, 0x9820, 0x9a9a },
			{ 0, 0xd3d3, 0xd7d7, 0xcfcf },
			{ 0, 0x5555, 0x5757, 0x5353 },
			{ 0, 0xefef, 0x2929, 0x2929 },
			{ 0, 0x8a8a, 0xe2e2, 0x3434 },
			{ 0, 0xfcfc, 0xe9e9, 0x4f4f },
			{ 0, 0x7272, 0x9f9f, 0xcfcf },
			{ 0, 0xadad, 0x7f7f, 0xa8a8 },
			{ 0, 0x3434, 0xe2e2, 0xe2e2 },
			{ 0, 0xeeee, 0xeeee, 0xecec }
		};

        this.background_transparent = false;
        this.scroll_on_keystroke = true;
		this.set_font_from_string("FreeMono");
		this.set_colors({ 0, 0, 0, 0 },
						{ 0, 0xffff, 0xffff, 0xffff },
						color);

		// FIXME: fork_command is deprecated. Use fork_command_full instead.
		this.fork_command(null, null, null, GLib.Environment.get_home_dir(), true, true, true);
        //this.fork_command_full(Vte.PtyFlags.DEFAULT, null, {}, null, GLib.SpawnFlags.FILE_AND_ARGV_ZERO, this.gne, cpid);
		//bool Vte.Terminal.fork_command_full (Vte.PtyFlags pty_flags, string? working_directory, string[]? argv, string[]? envv, GLib.SpawnFlags spawn_flags, GLib.SpawnChildSetupFunc child_setup, GLib.Pid child_pid)
	}

	public void active_signals(Delegates.String title_changed)
	{
		this.button_press_event.connect(this.display_menu);
		this.window_title_changed.connect(() => title_changed(this.window_title));

		this.context_menu.active_signals(() => this.copy_clipboard(),
										 () => this.paste_clipboard());
	}

	public int calcul_width(int column_count)
	{
		return (this.allocation.width * column_count) / (int)(this.get_column_count());
	}

	public int calcul_height(int row_count)
	{
		return (this.allocation.height * row_count) / (int)(this.get_row_count());
	}

	private bool display_menu(Gdk.EventButton event)
	{
		if(event.button == 3) // 3 is the right button
		{
			this.context_menu.show_all();
			context_menu.popup(null, null, null, event.button, event.time);

			return true;
		}

		return false;
	}
}