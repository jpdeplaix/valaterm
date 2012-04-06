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

public class About : Gtk.AboutDialog
{
    // Set as a constant member to remove a gcc warning due to valac bug (See: https://bugzilla.gnome.org/show_bug.cgi?id=652310)
    const string[] all_authors = { "Jacques-Pascal Deplaix <jp.deplaix@gmail.com>" };

    private About(MainWindow parent_window)
    {
        this.transient_for = parent_window;
        this.program_name = "ValaTerm";
        this.version = Config.VERSION;
        this.copyright = "Copyright © 2010 Jacques-Pascal Deplaix";
        this.comments = tr("ValaTerm is a lightweight terminal written in Vala");
        this.logo = new Gdk.Pixbuf.from_xpm_data(Pictures.logo);
        this.website = "http://git-jpdeplaix.dyndns.org/valaterm/valaterm.git/";
        this.authors = all_authors;
        this.license = "Copyright © 2011 Jacques-Pascal Deplaix" +
            "\n" +
            "\nValaTerm is free software: you can redistribute it and/or modify" +
            "\nit under the terms of the GNU General Public License as published by" +
            "\nthe Free Software Foundation, either version 3 of the License, or" +
            "\n(at your option) any later version." +
            "\n" +
            "\nThis program is distributed in the hope that it will be useful," +
            "\nbut WITHOUT ANY WARRANTY; without even the implied warranty of" +
            "\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the" +
            "\nGNU General Public License for more details." +
            "\n" +
            "\nYou should have received a copy of the GNU General Public License" +
            "\nalong with this program.  If not, see <http://www.gnu.org/licenses/>.";
    }

    public static void display(MainWindow parent_window)
    {
        var window = new About(parent_window);

        window.run();
        window.destroy();
    }
}
