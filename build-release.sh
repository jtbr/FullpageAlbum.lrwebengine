#!/bin/bash
# Build the installable Fullpage release zip.
#
# Generates README.html from readme.md (the GitHub-facing markdown source) with
# pandoc, then packages the FullpageAlbum.lrwebengine plug-in folder plus
# README.html and license.txt at the top level (the classic Lightroom
# web-gallery release layout). The docs/ Pages site, build tooling, and git
# metadata are not included.
#
# Requires: pandoc, zip.
#
# Upload the result as a GitHub Release asset named FullpageAlbum.lrwebengine.zip
# so the home-page download link resolves to it:
#   https://github.com/jtbr/FullpageAlbum.lrwebengine/releases/latest/download/FullpageAlbum.lrwebengine.zip
set -e
cd "$(dirname "$0")"

# 1. Generate the in-package README.html from readme.md.
pandoc readme.md -f gfm -t html5 --template readme-template.html \
  --metadata pagetitle="Fullpage HTML5 Lightroom Web Album" \
  -o README.html

# 2. Package the release: plug-in folder + README.html + license.txt.
OUT="FullpageAlbum.lrwebengine.zip"
rm -f "$OUT"
zip -r "$OUT" FullpageAlbum.lrwebengine README.html license.txt \
  -x '*/.DS_Store' '*/Thumbs.db'
echo "Built $OUT"
