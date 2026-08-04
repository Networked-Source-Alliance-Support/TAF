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








---

## build all

---


Run after build

Your full pipeline becomes:

./scripts/build/build-all.sh

./scripts/audit/analyze-build.sh

Output:

===============================================
 BUILD ANALYSIS COMPLETE
===============================================

Status: PASS

PASS: 42
FAIL: 0
WARN: 0

Report:
reports/build-analysis.txt

JSON:
reports/build-analysis.json

Generated artifact:

reports/

├── build-analysis.txt
└── build-analysis.json

Example JSON:

{
  "framework": "Terminal Academy Framework",
  "analysis_date": "2026-08-04T18:00:00",

  "results": {
    "status": "PASS",
    "passed": 42,
    "failed": 0,
    "warnings": 0
  }
}

This gives Terminal Academy a complete lifecycle:

SOURCE
  |
  v
BUILD ALL
  |
  v
GENERATE FRAMEWORK
  |
  v
AUDIT ENGINE
  |
  v
VERIFIED RELEASE

The next evolution would be adding a RAIP release artifact generator so every successful build produces a signed, hash-verified framework release manifest.
