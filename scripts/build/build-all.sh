#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

BUILD_DIR="$ROOT_DIR/scripts/build"


echo "================================================"
echo " Terminal Academy Framework"
echo " Full Repository Build System"
echo " Version: 1.0.0"
echo "================================================"
echo


run_build(){

    local script="$1"

    echo
    echo "-----------------------------------------------"
    echo " Running: $script"
    echo "-----------------------------------------------"


    if [[ ! -f "$BUILD_DIR/$script" ]]; then

        echo "[ERROR] Missing builder: $script"
        exit 1

    fi


    chmod +x "$BUILD_DIR/$script"

    "$BUILD_DIR/$script"


    echo "[OK] $script completed"

}



echo "[1/6] Building core engine"

run_build build-core.sh



echo "[2/6] Building course modules"

run_build build-courses.sh



echo "[3/6] Building data layer"

run_build build-data.sh



echo "[4/6] Building tests"

run_build build-tests.sh



echo "[5/6] Building documentation"

run_build build-docs.sh



echo "[6/6] Building GitHub automation"

run_build build-github.sh



echo
echo "================================================"
echo " Running Structure Validation"
echo "================================================"


REQUIRED_PATHS=(

"academy.sh"

"core/bootstrap.sh"
"core/ui.sh"
"core/state.sh"
"core/course.sh"
"core/quiz.sh"
"core/validator.sh"
"core/certificate.sh"
"core/logger.sh"

"courses/registry/course.json"

"data/courses.json"

"tests/run-tests.sh"

"docs/architecture.md"

".github/workflows/test.yml"

)



FAILED=0


for item in "${REQUIRED_PATHS[@]}"
do

    if [[ -e "$ROOT_DIR/$item" ]]
    then

        echo "[PASS] $item"

    else

        echo "[FAIL] $item"

        FAILED=1

    fi

done



echo


if [[ "$FAILED" -eq 0 ]]
then

    echo "================================================"
    echo " BUILD SUCCESSFUL"
    echo "================================================"

    echo
    echo "Terminal Academy Framework is ready."
    echo
    echo "Next commands:"
    echo
    echo "  ./academy.sh courses"
    echo "  ./academy.sh progress"
    echo "  ./tests/run-tests.sh"


else

    echo "================================================"
    echo " BUILD FAILED"
    echo "================================================"

    exit 1

fi
