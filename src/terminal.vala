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

#if GTK2 && !VALAC_SUP_0_17_2
// Vte.Terminal.match_check was not well defined in the gtk+-2.0 binding
// before Valac 0.17.2 (see: https://bugzilla.gnome.org/show_bug.cgi?id=676882)
private extern string? vte_terminal_match_check(Vte.Terminal terminal,
                                                long col, long row,
                                                out int tag);
#endif

public class Terminal : Vte.Terminal
{
    private GLib.Pid? child_pid = null;
    private string shell = Terminal.get_shell();

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

        this.active_mouse("""(https?|ftps?)://\S+""");

        this.active_signals();
    }

    private void active_mouse(string str)
    {
        try
        {
            var regex = new GLib.Regex(str);
            int id = this.match_add_gregex(regex, 0);

            this.match_set_cursor_type(id, Gdk.CursorType.HAND2);
        }
        catch(GLib.RegexError error)
        {
            Errors.print(error);
        }
    }

    public string? get_link(long x, long y)
    {
        long col = x / this.get_char_width();
        long row = y / this.get_char_height();
        int tag;

        // Vte.Terminal.match_check need a non-null tag instead of what is
        // written in the doc
        // (see: https://bugzilla.gnome.org/show_bug.cgi?id=676886)
#if GTK2 && !VALAC_SUP_0_17_2
        return vte_terminal_match_check(this, col, row, out tag);
#else
        return this.match_check(col, row, out tag);
#endif
    }

    private void active_signals()
    {
        this.window_title_changed.connect(() => {
                this.title_changed(this.window_title);
            });
    }

    public async void active_shell(string dir)
    {
        Idle.add(this.active_shell.callback, GLib.Priority.LOW);
        yield;

        try
        {
            var args = new string[0];

            GLib.Shell.parse_argv(this.shell, out args);

            if(Settings.command != null)
            {
                args += "-c";
                args += (!)(Settings.command);
            }

            this.fork_command_full(Vte.PtyFlags.DEFAULT, dir, args, null,
                                   GLib.SpawnFlags.SEARCH_PATH, null,
                                   out this.child_pid);
        }
        catch(GLib.Error error)
        {
            Errors.print(error);
        }
    }

    public int calcul_width(int column_count)
    {
        return (int)(this.get_char_width()) * column_count;
    }

    public int calcul_height(int row_count)
    {
        return (int)(this.get_char_height()) * row_count;
    }

    public bool has_foreground_process()
    {
#if GTK2
        int pty = this.pty;
#else
        int pty = this.pty_object.fd;
#endif
        int fgpid = Posix.tcgetpgrp(pty);

        return fgpid != this.child_pid && fgpid != -1;
    }

    private static string get_shell()
    {
        string? shell = Vte.get_user_shell();

        if(shell == null)
        {
            shell = "/bin/sh";
        }

        return (!)(shell);
    }

    //FIXME: Is it portable ?
    //Will be replaced by Vte.Terminal.get_current_directory_uri (vte 0.35)
    public string? get_shell_cwd()
    {
        int pid = (!)(this.child_pid);

        try
        {
            return GLib.FileUtils.read_link("/proc/%d/cwd".printf(pid));
        }
        catch(GLib.FileError error)
        {
            Errors.print(error);
        }

        return null;
    }
}
