#!/bin/sh
set -eu

BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
SRC="$BASE/box64"

sudo apt-get update
sudo apt-get install -y git cmake build-essential dpkg-dev curl ca-certificates

if [ ! -d "$SRC/.git" ]; then
  git clone --depth 1 https://github.com/ptitSeb/box64.git "$SRC"
fi

mkdir -p "$SRC/build"
cd "$SRC/build"
cmake .. -DARM_DYNAREC=ON -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j2
