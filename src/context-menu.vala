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

public class ContextMenu : Gtk.Menu
{
    private ImageMenuItem item_copy = new ImageMenuItem(Icons.COPY);
    private ImageMenuItem item_paste = new ImageMenuItem(Icons.PASTE);
    private CheckMenuItem item_display_menubar = new CheckMenuItem(tr("Menu Bar"), Settings.show_menubar);
    private ImageMenuItem item_new_window = new ImageMenuItem(Icons.NEW, tr("New Window"));
    private ImageMenuItem item_select_all = new ImageMenuItem(Icons.SELECT_ALL);
    private ImageMenuItem item_preferences = new ImageMenuItem(Icons.PREFERENCES);
    private ImageMenuItem item_clear = new ImageMenuItem(Icons.CLEAR);

    public signal void copy();
    public signal void paste();
    public signal void display_menubar(bool show);
    public signal void new_window();
    public signal void select_all();
    public signal void preferences();
    public signal void clear();

    public ContextMenu()
    {
        this.append(this.item_copy);
        this.append(this.item_paste);
        this.append(this.item_select_all);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(this.item_display_menubar);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(this.item_new_window);
        this.append(this.item_preferences);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(this.item_clear);

        this.active_signals();
    }

    private void active_signals()
    {
        this.item_copy.activate.connect(() => this.copy());
        this.item_paste.activate.connect(() => this.paste());
        this.item_display_menubar.activate.connect(() => {
                Settings.show_menubar = this.item_display_menubar.active;
                this.display_menubar(this.item_display_menubar.active);
            });
        this.item_new_window.activate.connect(() => this.new_window());
        this.item_select_all.activate.connect(() => this.select_all());
        this.item_preferences.activate.connect(() => this.preferences());
        this.item_clear.activate.connect(() => this.clear());
    }
}
