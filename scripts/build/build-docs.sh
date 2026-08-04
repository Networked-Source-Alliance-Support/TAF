#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

DOCS="$ROOT_DIR/docs"


echo "=============================================="
echo " Building Documentation"
echo "=============================================="


mkdir -p "$DOCS"



cat > "$DOCS/architecture.md" <<'EOF'
# Terminal Academy Framework Architecture


## Overview

TAF is a modular terminal-native education framework.


Architecture:
