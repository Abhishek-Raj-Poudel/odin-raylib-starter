#!/usr/bin/env bash
set -e

OUT="game"
ODIN=${ODIN:-odin}

$ODIN build . -collection:.. -out:$OUT
echo "Built $OUT"
./$OUT
