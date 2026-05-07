#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
deno run --quiet \
  --allow-env \
  --allow-read="$HOME" \
  --allow-net=api.github.com \
  --allow-write="$DIR" \
  "$DIR/src/index.ts"
