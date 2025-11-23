#!/usr/bin/env bash
set -euo pipefail

# For ancient systems where you've got a tiny home directory
exit 0 # Remove before running

# Where your big storage lives
NFS_BASE="/nfs/youruser" # <-- CHANGE THIS

HOME_BASE="$HOME"

DIRS=(
  ".tmux"
  ".antidote"
  ".config"
  ".cargo"
  "bin"
  ".npm"
  "go"
  ".cache"
  ".local"
  ".var"
  ".env"
  ".vscode"
)

mkdir -p "$NFS_BASE"

for d in "${DIRS[@]}"; do
  SRC="$HOME_BASE/$d"
  DST="$NFS_BASE/$d"

  echo "Processing $d..."

  # If already a symlink, ensure target exists and skip
  if [ -L "$SRC" ]; then
    echo "  -> Already a symlink"
    mkdir -p "$DST"
    continue
  fi

  # If real directory exists, move it
  if [ -d "$SRC" ]; then
    echo "  -> Moving existing directory to NFS"
    mkdir -p "$(dirname "$DST")"
    mv "$SRC" "$DST"
  else
    echo "  -> Directory doesn't exist in HOME, creating target on NFS"
    mkdir -p "$DST"
  fi

  # If source still exists and isn't a directory (e.g file), don't touch it
  if [ -e "$SRC" ] && [ ! -d "$SRC" ]; then
    echo "  !! $SRC exists but is not a directory, skipping"
    continue
  fi

  # If source doesn't exist, ensure parent dir exists
  mkdir -p "$(dirname "$SRC")"

  # Remove empty directory if it exists
  if [ -d "$SRC" ]; then
    rmdir "$SRC" 2>/dev/null || true
  fi

  # Finally link
  ln -s "$DST" "$SRC"
  echo "  -> Symlinked $SRC -> $DST"
done

echo "All directories now exist and point to NFS."
