#!/bin/bash

if [ -f "Makefile" ]; then
  echo "[INFO] Makefile is located in current dir"
  if command -v compiledb &> /dev/null; then
    echo "[INFO] compiledb utility is in \$PATH"
    compiledb make
  else
    echo "[ERROR] compiledb is not present in \$PATH"
  fi

    echo "[INFO] Creating .clangd file..."
    cat << 'EOF' > .clangd
CompileFlags:
  Add:
    - -fno-modules
    - -fno-implicit-modules
    - -fno-implicit-module-maps
    - -isysroot
    - /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk
EOF
  echo "[INFO] .clangd file created successfully"
fi

if [ -f ".gitignore" ]; then
  if ! grep -qxF "compile_commands.json" .gitignore; then 
    echo "compile_commands.json" >> .gitignore
  fi
fi
