#!/bin/bash
# Sync the latest release files from the Mercurial development repo into this
# git release repo. Development and testing happen in the hg repo (it has the
# full history and is where the plug-in is exercised in Lightroom); this repo is
# the public mirror that GitHub serves and that releases are built from.
#
# Usage:
#   ./sync-from-hg.sh [path-to-hg-FullpageAlbum.lrwebengine]
#
# Default hg source is "../Web Galleries/FullpageAlbum.lrwebengine" (relative to
# this repo). After running, review with `git status`, then commit (the script
# prints the source hg revision to cite) and, when releasing, run
# ./build-release.sh and attach the zip to a GitHub Release.
#
# Requires: hg, rsync.
set -e
cd "$(dirname "$0")"
HG_SRC="${1:-../Web Galleries/FullpageAlbum.lrwebengine}"

if [ ! -d "$HG_SRC/.hg" ]; then
  echo "Error: '$HG_SRC' is not a Mercurial repo (no .hg). Pass the path as an argument." >&2
  exit 1
fi

if hg --cwd "$HG_SRC" status -mard | grep -q .; then
  echo "Warning: the hg source has uncommitted changes; syncing the working tree as-is." >&2
fi

HGID=$(hg --cwd "$HG_SRC" id -i)
echo "Syncing from $HG_SRC (hg rev $HGID) ..."

# 1. The installable plug-in folder. --delete mirrors deletions; exclude the
#    non-shipped/internal/generated files (dev tools, docs site, the markdown
#    source, the generated README.html, the root license, the authoring-only
#    JustStrings companion, hg metadata, editor cruft).
rsync -a --delete \
  --exclude='.hg/' --exclude='.hgignore' --exclude='.vscode/' \
  --exclude='dev/' --exclude='docs/' \
  --exclude='CLAUDE.md' --exclude='TODO.txt' \
  --exclude='readme.md' --exclude='README.html' --exclude='license.txt' \
  --exclude='strings/en/JustStrings.txt' \
  --exclude='*.orig' --exclude='.DS_Store' --exclude='Thumbs.db' \
  "$HG_SRC/" "FullpageAlbum.lrwebengine/"

# 2. Root-level files: the GitHub Pages site, the readme source, the license.
rsync -a --delete "$HG_SRC/docs/" "docs/"
cp "$HG_SRC/readme.md" "readme.md"
cp "$HG_SRC/license.txt" "license.txt"

echo
echo "Done. Synced from hg rev $HGID."
echo "Next: review 'git status', then e.g.:"
echo "  git add -A && git commit -m \"Sync from hg rev $HGID\""
echo "  ./build-release.sh   # then attach FullpageAlbum.lrwebengine.zip to a GitHub Release"
