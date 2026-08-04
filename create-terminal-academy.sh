#!/usr/bin/env bash

set -euo pipefail

PROJECT="terminal-academy"

echo "=============================================="
echo " Terminal Academy Framework Repo Generator"
echo " Version: 1.0.0"
echo "=============================================="

# Create root
mkdir -p "$PROJECT"

cd "$PROJECT"

echo "[+] Creating root files..."

touch \
README.md \
LICENSE \
VERSION \
install.sh \
academy.sh

echo "1.0.0" > VERSION


echo "[+] Creating core engine..."

mkdir -p core

touch \
core/bootstrap.sh \
core/ui.sh \
core/state.sh \
core/course.sh \
core/quiz.sh \
core/validator.sh \
core/certificate.sh \
core/logger.sh


echo "[+] Creating course system..."

mkdir -p courses/registry

touch \
courses/registry/course.json \
courses/registry/course.sh \
courses/registry/quiz.json


mkdir -p courses/registry/lessons

touch \
courses/registry/lessons/lesson-001.sh \
courses/registry/lessons/lesson-002.sh \
courses/registry/lessons/lesson-003.sh \
courses/registry/lessons/lesson-004.sh


mkdir -p courses/registry/labs

touch \
courses/registry/labs/lab-001.sh \
courses/registry/labs/lab-002.sh


echo "[+] Creating data system..."

mkdir -p data/schemas

touch \
data/courses.json \
data/schemas/certificate.schema.json


echo "[+] Creating certificate storage..."

mkdir -p certificates


echo "[+] Creating test suite..."

mkdir -p tests

touch \
tests/run-tests.sh \
tests/test-state.sh \
tests/test-course.sh \
tests/test-validator.sh


echo "[+] Creating documentation..."

mkdir -p docs

touch \
docs/architecture.md \
docs/contributing.md \
docs/course-authoring.md


echo "[+] Creating GitHub Actions..."

mkdir -p .github/workflows

touch \
.github/workflows/test.yml


echo "[+] Setting executable permissions..."

chmod +x \
academy.sh \
install.sh \
tests/*.sh \
core/*.sh \
courses/registry/lessons/*.sh \
courses/registry/labs/*.sh


echo
echo "=============================================="
echo " Terminal Academy Framework created!"
echo "=============================================="
echo
echo "Location:"
echo "$(pwd)"
echo
echo "Structure:"
tree -L 3 2>/dev/null || find . -maxdepth 3 -type d | sort

echo
echo "Next steps:"
echo
echo "cd $PROJECT"
echo "./academy.sh help"
echo
