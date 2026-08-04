Make executable

From repository root:

chmod +x scripts/build/build-all.sh
Run the entire framework generator
./scripts/build/build-all.sh

Expected output:

================================================
 Terminal Academy Framework
 Full Repository Build System
================================================

[1/6] Building core engine
[OK] build-core.sh completed

[2/6] Building course modules
[OK] build-courses.sh completed

[3/6] Building data layer
[OK] build-data.sh completed

[4/6] Building tests
[OK] build-tests.sh completed

[5/6] Building documentation
[OK] build-docs.sh completed

[6/6] Building GitHub automation
[OK] build-github.sh completed


================================================
 Running Structure Validation
================================================

[PASS] academy.sh
[PASS] core/bootstrap.sh
[PASS] core/ui.sh
[PASS] core/state.sh
[PASS] core/course.sh
[PASS] core/quiz.sh
[PASS] core/validator.sh
[PASS] core/certificate.sh
[PASS] core/logger.sh
[PASS] courses/registry/course.json
[PASS] data/courses.json
[PASS] tests/run-tests.sh
[PASS] docs/architecture.md
[PASS] .github/workflows/test.yml


================================================
 BUILD SUCCESSFUL
================================================

Terminal Academy Framework is ready.

Your repository now has a proper software build pipeline:

scripts/build/

        build-all.sh
              |
              |
      +-------+-------+
      |       |       |
   Core    Courses   Data
      |
   Tests
      |
   Docs
      |
   GitHub CI

This changes Terminal Academy from a collection of scripts into a self-generating framework. A fresh clone can become a working academy platform with:

./scripts/build/build-all.sh

That is the same pattern used by larger developer platforms: a reproducible build layer that constructs the environment from source.
