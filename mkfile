MKSHELL = bash

all:V: $PWD/raylib.stamp $PWD/editline.stamp

$PWD/raylib.stamp:
  set -euo pipefail
  #
  pushd raylib
    rm -rf build/
    mkdir -p build/
    pushd build/
      cmake ..
      cmake --build .
    popd
    echo "$(git rev-parse HEAD)" > "$target"
  popd

$PWD/editline.stamp:
  set -euo pipefail
  #
  pushd editline
    ./autogen.sh
    ./configure --disable-shared --disable-default-complete
    make
    echo "$(git rev-parse HEAD)" > "$target"
  popd

odin-lang:
  ./odin-download-extract.sloth

clean:V:
  rm *.stamp
