#!/usr/bin/env bash
# Sourced by build.sh so both cppast and the secondary clang AST pass agree.
if [[ "$(uname)" == "Darwin" ]]; then
  terra_llvm_prefix=$(brew --prefix llvm@15)
  test -x "$terra_llvm_prefix/bin/clang++"
  test -f "$terra_llvm_prefix/include/c++/v1/vector"
  terra_sdk=$(env -u SDKROOT xcrun --show-sdk-path)
  # Terra removes PATH entries containing "llvm" in its secondary pass. A real
  # wrapper (not a symlink) also preserves clang's installed-header discovery.
  # Homebrew clang can bake in a different CLT SDK; force its sysroot too.
  terra_compiler_dir=$(mktemp -d "${TMPDIR:-/tmp}/terra-compiler.XXXXXX")
  printf '#!/bin/bash\nexec "%s/bin/clang++" -isysroot "%s" "$@"\n' "$terra_llvm_prefix" "$terra_sdk" > "$terra_compiler_dir/clang++"
  printf '#!/bin/bash\nexec "%s/bin/clang" -isysroot "%s" "$@"\n' "$terra_llvm_prefix" "$terra_sdk" > "$terra_compiler_dir/clang"
  chmod +x "$terra_compiler_dir/clang++" "$terra_compiler_dir/clang"
  export PATH="$terra_compiler_dir:$PATH"
  # Do not prepend SDK C headers ahead of clang's builtin headers (stddef.h).
  unset SDKROOT CPLUS_INCLUDE_PATH C_INCLUDE_PATH CPATH
  clang++ --version
fi
