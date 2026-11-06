#!/bin/sh
set -eu

BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
ROOT="$BASE/x86-root"
CACHE="$BASE/x86-debs"
LISTS="$BASE/apt-lists"
mkdir -p "$ROOT" "$CACHE" "$LISTS/partial"

cat >"$BASE/amd64.sources" <<'EOF'
Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

APT_OPTS="-o Dir::Etc::sourcelist=$BASE/amd64.sources -o Dir::Etc::sourceparts=- -o Dir::State::lists=$LISTS -o APT::Architecture=amd64"
apt-get $APT_OPTS update
cd "$CACHE"

for pkg in \
  libc6 libgcc-s1 libstdc++6 zlib1g libfontconfig1 libfreetype6 \
  libx11-6 libxext6 libxrender1 libxrandr2 libxi6 libxinerama1 libsm6 \
  libice6 libxcb1 libglib2.0-0t64 libicu76 libpcre2-16-0 libpcre2-8-0 \
  libzstd1 libb2-1 libdouble-conversion3 libmd4c0 libpng16-16t64 \
  libharfbuzz0b libbrotli1 libgraphite2-3 libexpat1 libxkbcommon0 \
  libxkbcommon-x11-0 libx11-xcb1 libxcb-cursor0 libxcb-icccm4 \
  libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 \
  libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-util1 libxcb-xfixes0 \
  libxcb-xkb1 libpcsclite1 libqt6core6t64 libqt6gui6 libqt6widgets6 \
  libqt6dbus6 libqt6network6 libqt6xml6 libqt6printsupport6 qt6-qpa-plugins
do
  apt-get $APT_OPTS download "$pkg" >/dev/null 2>&1 || echo "warning: unavailable: $pkg"
done

for deb in ./*.deb; do
  [ -e "$deb" ] && dpkg-deb -x "$deb" "$ROOT"
done
