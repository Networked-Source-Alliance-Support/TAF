#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

WORKFLOW="$ROOT_DIR/.github/workflows"


echo "=============================================="
echo " Building GitHub Actions"
echo "=============================================="


mkdir -p "$WORKFLOW"



cat > "$WORKFLOW/test.yml" <<'EOF'
name: Terminal Academy Tests


on:

  push:

  pull_request:



jobs:

  test:

    runs-on: ubuntu-latest


    steps:

    - name: Checkout
      uses: actions/checkout@v4


    - name: Install dependencies
      run: |
        sudo apt update
        sudo apt install -y jq


    - name: Run tests
      run: |
        chmod +x tests/*.sh
        ./tests/run-tests.sh

EOF



cat > "$WORKFLOW/build.yml" <<'EOF'
name: Build Validation


on:

  workflow_dispatch:


jobs:

 build:

  runs-on: ubuntu-latest


  steps:

  - uses: actions/checkout@v4


  - name: Verify structure
    run: |

      test -f academy.sh
      test -d core
      test -d courses
      test -d tests

      echo "Framework structure valid"

EOF


echo "GitHub workflows created."
