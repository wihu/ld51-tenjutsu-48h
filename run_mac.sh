#!/bin/bash
# Builds (if needed) and runs the native macOS (arm64, HashLink/C) build of Tenjutsu.
#
# Requires:
#   - Haxe + haxelib
#   - Homebrew hashlink (`brew install hashlink`) — provides hl.h/hlc.h/libhl.dylib
#     and prebuilt sdl/fmt/ui/uv .hdll files for arm64.
#   - haxelib packages: castle (git, for the 2-arg cdb.Parser.parse API),
#     hashlink (registry, for the Run.hx build-script + make template),
#     hlsdl, hlopenal (audio — Heaps' sound backend is gated behind
#     `#if hlopenal`; without it the build silently falls back to a
#     no-op/silent sound emulator), plus the usual
#     heaps/hscript/deepnightLibs/ldtk-haxe-api/heaps-aseprite.
#   - build.mac.hxml shadows the global `ase` haxelib with patches/ase/src, which
#     renames its BYTE_SIZE constants (they collide with macOS's
#     mach/arm/vm_param.h BYTE_SIZE macro). This keeps the global ase install
#     untouched — see patches/ase/README.md.
set -euo pipefail
cd "$(dirname "$0")"

HASHLINK_HOME=$(brew --prefix hashlink)

if [ ! -x bin/mac/client ] || [ "${1-}" = "--rebuild" ]; then
  echo "Building native client..."
  rm -rf bin/mac
  HASHLINK="$HASHLINK_HOME" LIBRARY_PATH=/opt/homebrew/lib haxe build.mac.hxml
fi

echo "Running..."
DYLD_LIBRARY_PATH="$HASHLINK_HOME/lib:/opt/homebrew/lib" bin/mac/client
