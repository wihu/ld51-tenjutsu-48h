# Tenjutsu 
This is the source code of **Tenjutsu**, a 48h game created for Ludum Dare 51.

[Play it online](https://deepnight.net/games/tenjutsu/) | [Homepage](https://deepnight.net)

It's written in Haxe language and uses Heaps engine and GameBase framework.

## Running on macOS (Apple Silicon)

Homebrew's arm64 `hashlink` build ships no `hl` JIT interpreter (JIT isn't
supported on arm64), so this fork adds a native build via HL/C instead
(compiles straight to a native arm64 executable, no Rosetta needed).

```
brew install hashlink haxe
haxelib install heaps 2.0.0                # latest (2.1.0) fails to compile on hl (Flow.hx references an undefined `dom` field)
haxelib install ldtk-haxe-api 1.5.3-rc.1   # latest registry release (1.0.0) predates this project's .ldtk jsonVersion (1.5.4)
haxelib install hscript deepnightLibs heaps-aseprite hlsdl hlopenal hashlink
haxelib git castle https://github.com/ncannasse/castle.git   # registry release predates the 2-arg cdb.Parser.parse API deepnightLibs needs
./run_mac.sh            # builds bin/mac/client if missing, then runs it
./run_mac.sh --rebuild   # force a rebuild
```

See `build.mac.hxml`, `run_mac.sh`, and `patches/ase/README.md` for details
on the two build-time workarounds this needed (a `BYTE_SIZE` naming collision
with a macOS system header, and a stale `libuv` link path).
