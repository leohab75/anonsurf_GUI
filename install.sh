#!/bin/bash

mkdir /tmp/anonsurf
mv anonsurf-src /tmp/anonsurf
mv souce.sh /tmp/anonsurf
mv remove.sh /tmp/anonsurf
mv Uninstall-Anonsurf.desktop /tmp/anonsurf


pkexec sh /tmp/anonsurf/souce.sh

desktop-file-validate /usr/share/applications/anonsurf.desktop

desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop

rm -rf /tmp/anonsurf
rm -rf $(pwd)

exit 0;
