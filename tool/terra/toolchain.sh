#!/usr/bin/env bash
# Sourced by build.sh so both cppast and the secondary clang AST pass agree.
if [[ "$(uname)" == "Darwin" ]]; then
  terra_llvm_prefix=$(brew --prefix llvm@15)
  test -x "$terra_llvm_prefix/bin/clang++"
  test -f "$terra_llvm_prefix/include/c++/v1/vector"
  terra_sdk=$(env -u SDKROOT xcrun --show-sdk-path)
  # Terra removes PATH entries containing "llvm" in its secondary pass. A real
  # wrapper (not a symlink) also preserves clang's installed-header discovery.
  terra_compiler_dir=$(mktemp -d "${TMPDIR:-/tmp}/terra-compiler.XXXXXX")
  printf '#!/bin/bash\nexec "%s/bin/clang++" "$@"\n' "$terra_llvm_prefix" > "$terra_compiler_dir/clang++"
  printf '#!/bin/bash\nexec "%s/bin/clang" "$@"\n' "$terra_llvm_prefix" > "$terra_compiler_dir/clang"
  chmod +x "$terra_compiler_dir/clang++" "$terra_compiler_dir/clang"
  export PATH="$terra_compiler_dir:$PATH"
  export CPLUS_INCLUDE_PATH="$terra_sdk/usr/include"
  unset SDKROOT
  clang++ --version
fi
