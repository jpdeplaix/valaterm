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

public class ParametersWindow : DefaultDialog
{
    private FontButton font_chooser = new FontButton(Settings.font);
    private ColorButton background_color_chooser = new ColorButton(
        Settings.background_color);
    private ColorButton foreground_color_chooser = new ColorButton(
        Settings.foreground_color);
    private SpinButton scrollback_lines_chooser = new SpinButton(
        Settings.scrollback_lines);
    private CheckButton transparency_chooser = new CheckButton(
        Settings.transparency);
    private CheckButton show_scrollbar_chooser = new CheckButton(
        Settings.show_scrollbar);

    public signal void font_changed(string font);
    public signal void background_color_changed(Gdk.Color color);
    public signal void foreground_color_changed(Gdk.Color color);
    public signal void scrollback_lines_changed(long lines);
    public signal void transparency_changed(bool tranparency);
    public signal void show_scrollbar_changed(bool show);

    public ParametersWindow(MainWindow parent_window)
    {
        this.title = tr("ValaTerm Preferences");
        this.transient_for = parent_window;

        var main_box = (Gtk.Box)(this.get_content_area());

        main_box.pack_start(new ParameterBox(tr("Font:"), this.font_chooser));
        main_box.pack_start(new ParameterBox(tr("Background color:"),
                                             this.background_color_chooser));
        main_box.pack_start(new ParameterBox(tr("Foreground color:"),
                                             this.foreground_color_chooser));
        main_box.pack_start(new ParameterBox(tr("Scrollback lines:"),
                                             this.scrollback_lines_chooser));
        main_box.pack_start(new ParameterBox(tr("Transparency:"),
                                             this.transparency_chooser));
        main_box.pack_start(new ParameterBox(tr("Show scrollbar:"),
                                             this.show_scrollbar_chooser));
    }

    protected override void ok_clicked()
    {
        string font_name = this.font_chooser.font_name;
        Gdk.Color background_color = this.background_color_chooser.color;
        Gdk.Color foreground_color = this.foreground_color_chooser.color;
        int scrollback_lines = this.scrollback_lines_chooser.get_value_as_int();
        bool transparency = this.transparency_chooser.active;
        bool show_scrollbar = this.show_scrollbar_chooser.active;

        if(Settings.font != font_name)
        {
            Settings.font = font_name;
            this.font_changed(font_name);
        }

/* Vala bug: 623092 (https://bugzilla.gnome.org/show_bug.cgi?id=623092) */
#if VALA_0_12
        if(Settings.background_color != background_color)
#endif
        {
            Settings.background_color = background_color;
            this.background_color_changed(background_color);
        }

/* Vala bug: 623092 (https://bugzilla.gnome.org/show_bug.cgi?id=623092) */
#if VALA_0_12
        if(Settings.foreground_color != foreground_color)
#endif
        {
            Settings.foreground_color = foreground_color;
            this.foreground_color_changed(foreground_color);
        }

        if(Settings.scrollback_lines != scrollback_lines)
        {
            Settings.scrollback_lines = scrollback_lines;
            this.scrollback_lines_changed(scrollback_lines);
        }

        if(Settings.transparency != transparency)
        {
            Settings.transparency = transparency;
            this.transparency_changed(transparency);
        }

        if(Settings.show_scrollbar != show_scrollbar)
        {
            Settings.show_scrollbar = show_scrollbar;
            this.show_scrollbar_changed(show_scrollbar);
        }
    }
}
