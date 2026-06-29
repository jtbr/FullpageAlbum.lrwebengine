#!/bin/bash
# Build the installable Fullpage release zip.
#
# The zip contains the FullpageAlbum.lrwebengine plug-in folder plus README.html
# and license.txt at the top level (the classic Lightroom web-gallery release
# layout). The docs/ GitHub Pages site, git metadata, and this script are
# excluded. Upload the result as a GitHub Release asset named
# FullpageAlbum.lrwebengine.zip so the home-page download link resolves to it:
#   https://github.com/jtbr/FullpageAlbum.lrwebengine/releases/latest/download/FullpageAlbum.lrwebengine.zip
set -e
cd "$(dirname "$0")"
OUT="FullpageAlbum.lrwebengine.zip"
rm -f "$OUT"
zip -r "$OUT" . \
  -x './.git/*' './docs/*' './build-release.sh' './.gitignore' './*.zip' '*/.DS_Store' '*/Thumbs.db'
echo "Built $OUT"
