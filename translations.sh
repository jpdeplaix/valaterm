#!/bin/sh

# Update the pot file
xgettext -L C# --keyword=tr --from-code=utf-8 src/*.vala -o po/messages.pot
