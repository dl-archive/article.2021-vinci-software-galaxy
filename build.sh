#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original camera-ready build (Aug 2021, TeX Live 2019).
# Requires podman (or docker: export ENGINE=docker). Output: build/article.software-galaxies.pdf
# openout_any=a: bibtex runs from /src and must write its .bbl/.blg to /out
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2019-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out article.software-galaxies.tex
