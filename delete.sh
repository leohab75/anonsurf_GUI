#!/bin/bash

rm -f /usr/share/applications/anonsurf.desktop
rm -f /usr/share/applications/Uninstall-Anonsurf.desktop
unlink /usr/share/applications/anonsurf.desktop
dpkg -P anonsurf
rm -rf /opt/anonsurf
