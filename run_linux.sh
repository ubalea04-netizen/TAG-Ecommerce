#!/bin/bash

# Run the Flutter Linux app in this container using a headless X11 display.
# Usage: ./run_linux.sh

set -e
cd "$(dirname "$0")"

xvfb-run -a -s '-screen 0 1920x1080x24' flutter run -d linux
