# patches/ase

Vendored copy of the `ase` haxelib (v2.1.1), with `BYTE_SIZE` constants renamed
to `STRUCT_BYTE_SIZE` in `FrameHeader.hx`, `Frame.hx`, `chunks/Chunk.hx`, and
`chunks/ChunkHeader.hx`.

Why: on macOS, `mach/arm/vm_param.h` `#define`s `BYTE_SIZE` as `8`. The HL/C
build includes that system header transitively, so the generated C ends up
with `int 8;` instead of `int BYTE_SIZE;` for these struct fields, which fails
to compile.

`build.mac.hxml` puts `-cp patches/ase/src` *after* `_base.hxml`'s `-lib ase`.
Haxe's classpath resolution favors the last matching `-cp` for a given module,
not the first, so this shadows the global haxelib install instead of patching
it in place. Other builds (JS, DirectX) don't hit this collision and don't
reference this folder.
