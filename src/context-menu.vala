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
    private ImageMenuItem copy_link;
    private Gtk.SeparatorMenuItem copy_link_separator;

    public ContextMenu(ContextMenuItems items)
    {
        this.copy_link = items.copy_link;
        this.copy_link_separator = new Gtk.SeparatorMenuItem();

        this.copy_link_set_visible(false);

        this.append(this.copy_link);
        this.append(this.copy_link_separator);
        this.append(items.copy);
        this.append(items.paste);
        this.append(items.select_all);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(items.display_menubar);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(items.new_window);
        this.append(items.preferences);
        this.append(new Gtk.SeparatorMenuItem());
        this.append(items.clear);
    }

    public void copy_link_set_visible(bool is_visible)
    {
        this.copy_link.visible = is_visible;
        this.copy_link_separator.visible = is_visible;
    }
}
