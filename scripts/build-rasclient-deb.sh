#!/bin/sh
set -eu

BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
RASCLIENT_DEB="${RASCLIENT_DEB:-}"
STAGE="$BASE/pkg-stage"
OUT="$BASE/rasclient-box64_0.1.0_arm64.deb"

if [ -z "$RASCLIENT_DEB" ] || [ ! -f "$RASCLIENT_DEB" ]; then
  echo "Set RASCLIENT_DEB to the official Parallels RAS Linux amd64 .deb" >&2
  exit 1
fi
test -x "$BASE/box64/build/box64"
rm -rf "$STAGE"
mkdir -p "$STAGE/DEBIAN" "$STAGE/opt/rasclient-box64" "$STAGE/usr/bin" "$STAGE/usr/share/applications"

dpkg-deb -x "$RASCLIENT_DEB" "$STAGE/opt/rasclient-box64/client-root"
cp "$BASE/box64/build/box64" "$STAGE/opt/rasclient-box64/box64"
cp -a "$BASE/x86-root" "$STAGE/opt/rasclient-box64/x86-root"

cat >"$STAGE/usr/bin/rasclient-box64" <<'EOF'
#!/bin/sh
set -eu
BASE=/opt/rasclient-box64
ROOT="$BASE/x86-root"
CLIENT="$BASE/client-root"
export BOX64_LD_LIBRARY_PATH="$CLIENT/opt/2X/Client/lib:$ROOT/lib/x86_64-linux-gnu:$ROOT/usr/lib/x86_64-linux-gnu"
export BOX64_EMULATED_LIBS="libssl.so.3:libcrypto.so.3:libpng16.so.16:libfreetype.so.6:libharfbuzz.so.0:libfontconfig.so.1:libb2.so.1:libdouble-conversion.so.3:libpcre2-16.so.0:libpcre2-8.so.0"
export BOX64_PREFER_WRAPPED=0
export QT_PLUGIN_PATH="$ROOT/usr/lib/x86_64-linux-gnu/qt6/plugins"
export QT_QPA_PLATFORM_PLUGIN_PATH="$ROOT/usr/lib/x86_64-linux-gnu/qt6/plugins/platforms"
export QT_QPA_PLATFORM=xcb
exec "$BASE/box64" "$CLIENT/opt/2X/Client/bin/2XClient" "$@"
EOF

cat >"$STAGE/usr/bin/rasclient-appserverclient" <<'EOF'
#!/bin/sh
set -eu
BASE=/opt/rasclient-box64
ROOT="$BASE/x86-root"
CLIENT="$BASE/client-root"
export BOX64_LD_LIBRARY_PATH="$CLIENT/opt/2X/Client/lib:$ROOT/lib/x86_64-linux-gnu:$ROOT/usr/lib/x86_64-linux-gnu"
export BOX64_EMULATED_LIBS="libssl.so.3:libcrypto.so.3:libpng16.so.16:libfreetype.so.6:libharfbuzz.so.0:libfontconfig.so.1:libb2.so.1:libdouble-conversion.so.3:libpcre2-16.so.0:libpcre2-8.so.0"
export BOX64_PREFER_WRAPPED=0
exec "$BASE/box64" "$CLIENT/opt/2X/Client/bin/appserverclient" "$@"
EOF
chmod 0755 "$STAGE/usr/bin/rasclient-box64" "$STAGE/usr/bin/rasclient-appserverclient" "$STAGE/opt/rasclient-box64/box64"

cat >"$STAGE/usr/share/applications/rasclient-box64.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Parallels Client (Box64)
Comment=Unofficial experimental RAS client launcher
Exec=/usr/bin/rasclient-box64 %U
Icon=application-x-executable
Terminal=false
Categories=Network;RemoteAccess;
EOF

cat >"$STAGE/DEBIAN/control" <<'EOF'
Package: rasclient-box64
Version: 0.1.0
Section: net
Priority: optional
Architecture: arm64
Maintainer: RAS Insider contributors
Depends: libc6, libstdc++6, libglib2.0-0t64, libfontconfig1, libfreetype6, libx11-6, libxcb1, libxkbcommon0, libpcsclite1
Description: Unofficial experimental Parallels RAS launcher for Raspberry Pi 4
 Uses Box64 to run a user-supplied official Parallels Linux amd64 client.
EOF

dpkg-deb --build "$STAGE" "$OUT"
echo "Built $OUT"
