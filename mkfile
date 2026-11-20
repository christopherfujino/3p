MKSHELL = bash
CC = cc
CFLAGS =
LDFLAGS =

all:V: raylib.stamp editline.stamp

raylib.stamp:
  set -euo pipefail
  pushd raylib
    rm -rf build/
    mkdir -p build/
    pushd build/
      cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
      cmake --build .
    popd    # raylib/build/ -> raylib/
    echo "$(git rev-parse HEAD)" > "../${target}"
    echo    "CompileFlags:" > .clangd
    echo -e "  CompilationDatabase: \"$PWD/build/compile_commands.json\"" >> .clangd
  popd      # 3p/raylib/ -> 3p/

editline.stamp:
  set -euo pipefail
  pushd editline
    ./autogen.sh
    ./configure --disable-shared --disable-default-complete
    make
    echo "$(git rev-parse HEAD)" > "../${target}"
  popd

odin-lang:
  ./odin-download-extract.sloth

clean:V:
  rm *.stamp
