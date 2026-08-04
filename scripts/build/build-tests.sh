#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

TEST_DIR="$ROOT_DIR/tests"


echo "=============================================="
echo " Building Test Suite"
echo "=============================================="


mkdir -p "$TEST_DIR"



cat > "$TEST_DIR/run-tests.sh" <<'EOF'
#!/usr/bin/env bash

set -e

echo "Running Terminal Academy Tests"

./tests/test-state.sh
./tests/test-course.sh
./tests/test-validator.sh

echo
echo "All tests passed."
EOF



cat > "$TEST_DIR/test-state.sh" <<'EOF'
#!/usr/bin/env bash

source core/state.sh


reset_state


if [[ -f "$STATE_FILE" ]]
then
 echo "PASS: State engine"
else
 echo "FAIL: State engine"
 exit 1
fi
EOF



cat > "$TEST_DIR/test-course.sh" <<'EOF'
#!/usr/bin/env bash


COURSE="courses/registry/course.json"


if [[ -f "$COURSE" ]]
then

echo "PASS: Course metadata"

else

echo "FAIL: Course metadata"
exit 1

fi
EOF



cat > "$TEST_DIR/test-validator.sh" <<'EOF'
#!/usr/bin/env bash


source core/validator.sh


if validate_contains \
"hello org.opencontainers.image.source" \
"org.opencontainers.image.source"

then

echo "PASS: Validator"

else

echo "FAIL: Validator"
exit 1

fi
EOF



chmod +x "$TEST_DIR"/*.sh


echo "Tests created."
