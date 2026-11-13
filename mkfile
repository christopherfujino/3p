MKSHELL = bash

usage:QV:
  echo 'Specify individual targets (or allow them to be transitively fetched)' 2>&1
  false

$PWD/raylib.stamp:
  set -euo pipefail
  pushd raylib
    git submodule update
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
  pushd editline
    git submodule update
    ./autogen.sh
    ./configure --disable-shared --disable-default-complete
    make
    echo "$(git rev-parse HEAD)" > "$target"
  popd

odin-lang:
  ./odin-download-extract.sloth

clean:V:
  rm *.stamp
