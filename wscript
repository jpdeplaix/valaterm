#! /usr/bin/env python
# encoding: utf-8
# Copyright © 2011 Jacques-Pascal Deplaix

APPNAME = 'valaterm'
VERSION = '0.5.1'

top = '.'
out = 'build'

import waflib

def options(opt):
    opt.load(['compiler_c', 'vala'])

    opt.add_option('--debug',
                   help = 'Debug mode',
                   action = 'store_true',
                   default = False)

    opt.add_option('--with-gtk3',
                   help = 'Compile with Gtk 3.0 instead of Gtk 2.0 (Experimental mode).'
                   ' Works only with Vala >= 0.13.2',
                   action = 'store_true',
                   default = False)

    opt.add_option('--disable-nls',
                   help = 'Disable internationalisation (text in english).',
                   action = 'store_true',
                   default = False)

    opt.add_option('--custom-flags',
                   help = 'Use the user defined CFLAGS/LDFLAGS/VALAFLAGS only'
                   ' instead of the defaults ones followed by the'
                   ' user ones.',
                   action = 'store_true',
                   default = False)

def configure(conf):
    CFLAGS = list()
    VALAFLAGS = list()
    LINKFLAGS = list()

    conf.load(['compiler_c', 'vala'])

    if conf.options.disable_nls != True:
        conf.load(['intltool'])

    if conf.options.with_gtk3 == True:
        VALAFLAGS.extend(['--define=GTK3'])

    conf.load('vala', funs = '')
    conf.check_vala(min_version = conf.options.with_gtk3 and (0, 13, 2) or (0, 12, 1))

    if conf.env.VALAC_VERSION >= (0, 17, 2):
        VALAFLAGS.extend(['--define=VALAC_SUP_0_17_2'])

    glib_package_version = '2.16.0'
    gtk_package_version = conf.options.with_gtk3 and '3.0' or '2.16'
    gtk_package_name = conf.options.with_gtk3 and 'gtk+-3.0' or 'gtk+-2.0'
    vte_package_name = conf.options.with_gtk3 and 'vte-2.90' or 'vte'

    conf.check_cfg(
        package         = 'glib-2.0',
        uselib_store    = 'GLIB',
        atleast_version = glib_package_version,
        args            = '--cflags --libs')

    conf.check_cfg(
        package         = 'gobject-2.0',
        uselib_store    = 'GOBJECT',
        atleast_version = glib_package_version,
        args            = '--cflags --libs')

    conf.check_cfg(
        package         = 'gthread-2.0',
        uselib_store    = 'GTHREAD',
        atleast_version = glib_package_version,
        args            = '--cflags --libs')

    conf.check_cfg(
        package         = gtk_package_name,
        uselib_store    = 'GTK',
        atleast_version = gtk_package_version,
        args            = '--cflags --libs')

    conf.check_cfg(
        package         = vte_package_name,
        uselib_store    = 'VTE',
        atleast_version = '0.26',
        args            = '--cflags --libs')

    # Add /usr/local/include for compilation under OpenBSD
    CFLAGS.extend(['-I/usr/local/include', '-include', 'config.h'])
    VALAFLAGS.extend(['--thread'])
    conf.define('VERSION', VERSION)

    if conf.options.disable_nls == False:
        conf.define('GETTEXT_PACKAGE', APPNAME)
        VALAFLAGS.extend(['--define=ENABLE_NLS'])

    if conf.options.debug == True:
        CFLAGS.extend(['-ggdb3'])
        VALAFLAGS.extend(['-g', '--define=DEBUG',
            '--enable-experimental-non-null', '--enable-checking'])
    elif conf.options.custom_flags == False:
        CFLAGS.extend(['-pipe', '-O2'])
        LINKFLAGS.extend(['-Wl,-O1', '-s'])

    conf.env.prepend_value('CFLAGS', CFLAGS)
    conf.env.prepend_value('VALAFLAGS', VALAFLAGS)
    conf.env.prepend_value('LINKFLAGS', LINKFLAGS)

    conf.env.debug = conf.options.debug
    conf.env.with_gtk3 = conf.options.with_gtk3
    conf.env.disable_nls = conf.options.disable_nls

    conf.write_config_header('config.h')

def build(bld):
    if bld.env.disable_nls == False:
        bld(features = 'intltool_po', appname = APPNAME, podir = 'po')

    bld.program(
        packages      = [bld.env.with_gtk3 and 'vte-2.90' or 'vte', 'config', 'posix'],
        vapi_dirs     = 'vapi',
        target        = APPNAME,
        uselib        = ['GLIB', 'GOBJECT', 'GTHREAD', 'GTK', 'VTE'],
        source        = ['src/about.vala',
                         'src/accel.vala',
                         'src/check-button.vala',
                         'src/check-menu-item.vala',
                         'src/colors.vala',
                         'src/color-button.vala',
                         'src/config-file.vala',
                         'src/context-menu.vala',
                         'src/context-menu-items.vala',
                         'src/default-dialog.vala',
                         'src/errors.vala',
                         'src/font-button.vala',
                         'src/icons.vala',
                         'src/image-menu-item.vala',
                         'src/main.vala',
                         'src/main-window.vala',
                         'src/menu-bar.vala',
                         'src/menu-bar-items.vala',
                         'src/menu-item.vala',
                         'src/menu-items.vala',
                         'src/message-dialog.vala',
                         'src/parameters-window.vala',
                         'src/parameter-box.vala',
                         'src/pictures.vala',
                         'src/settings.vala',
                         'src/shortcut-box.vala',
                         'src/shortcuts-manager.vala',
                         'src/spin-button.vala',
                         'src/terminal.vala'])

def dist(ctx):
    ctx.excl = '**/.*'
