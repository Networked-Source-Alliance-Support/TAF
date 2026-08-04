#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

REPORT_DIR="$ROOT_DIR/reports"

mkdir -p "$REPORT_DIR"


TEXT_REPORT="$REPORT_DIR/build-analysis.txt"
JSON_REPORT="$REPORT_DIR/build-analysis.json"


PASS=0
FAIL=0
WARN=0


echo "===============================================" > "$TEXT_REPORT"
echo " Terminal Academy Build Analysis Report" >> "$TEXT_REPORT"
echo " Generated: $(date)" >> "$TEXT_REPORT"
echo "===============================================" >> "$TEXT_REPORT"
echo >> "$TEXT_REPORT"



check_path(){

    local expected="$1"
    local type="$2"


    if [[ "$type" == "file" && -f "$ROOT_DIR/$expected" ]]
    then

        echo "[PASS] FILE $expected" | tee -a "$TEXT_REPORT"
        ((PASS++))


    elif [[ "$type" == "dir" && -d "$ROOT_DIR/$expected" ]]
    then

        echo "[PASS] DIR  $expected" | tee -a "$TEXT_REPORT"
        ((PASS++))


    else

        echo "[FAIL] $type missing: $expected" | tee -a "$TEXT_REPORT"
        ((FAIL++))

    fi

}



echo "Analyzing framework structure..."

echo >> "$TEXT_REPORT"
echo "CORE ENGINE" >> "$TEXT_REPORT"
echo "-----------" >> "$TEXT_REPORT"


CORE_FILES=(

"core/bootstrap.sh"
"core/ui.sh"
"core/state.sh"
"core/course.sh"
"core/quiz.sh"
"core/validator.sh"
"core/certificate.sh"
"core/logger.sh"

)


for file in "${CORE_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "COURSE SYSTEM" >> "$TEXT_REPORT"
echo "-------------" >> "$TEXT_REPORT"


COURSE_FILES=(

"courses/registry/course.json"

"courses/registry/course.sh"

"courses/registry/quiz.json"

"courses/registry/lessons/lesson-001.sh"
"courses/registry/lessons/lesson-002.sh"
"courses/registry/lessons/lesson-003.sh"
"courses/registry/lessons/lesson-004.sh"

"courses/registry/labs/lab-001.sh"
"courses/registry/labs/lab-002.sh"

)


for file in "${COURSE_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "DATA LAYER" >> "$TEXT_REPORT"
echo "----------" >> "$TEXT_REPORT"


DATA_FILES=(

"data/courses.json"

"data/schemas/certificate.schema.json"

)


for file in "${DATA_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "TEST SUITE" >> "$TEXT_REPORT"
echo "----------" >> "$TEXT_REPORT"


TEST_FILES=(

"tests/run-tests.sh"

"tests/test-state.sh"

"tests/test-course.sh"

"tests/test-validator.sh"

)


for file in "${TEST_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "DOCUMENTATION" >> "$TEXT_REPORT"
echo "-------------" >> "$TEXT_REPORT"


DOC_FILES=(

"docs/architecture.md"

"docs/course-authoring.md"

"docs/contributing.md"

)


for file in "${DOC_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "CI/CD" >> "$TEXT_REPORT"
echo "-----" >> "$TEXT_REPORT"


CI_FILES=(

".github/workflows/test.yml"

".github/workflows/build.yml"

)


for file in "${CI_FILES[@]}"
do

check_path "$file" file

done



echo >> "$TEXT_REPORT"
echo "PERMISSION ANALYSIS"
echo "-------------------" >> "$TEXT_REPORT"



EXEC_FILES=(

"academy.sh"

"install.sh"

"scripts/build/build-all.sh"

)


for file in "${EXEC_FILES[@]}"
do


if [[ -x "$ROOT_DIR/$file" ]]
then

echo "[PASS] executable $file" | tee -a "$TEXT_REPORT"

((PASS++))


else

echo "[WARN] not executable $file" | tee -a "$TEXT_REPORT"

((WARN++))

fi


done



echo >> "$TEXT_REPORT"
echo "===============================================" >> "$TEXT_REPORT"
echo "SUMMARY" >> "$TEXT_REPORT"
echo "===============================================" >> "$TEXT_REPORT"


echo "PASS: $PASS" | tee -a "$TEXT_REPORT"
echo "FAIL: $FAIL" | tee -a "$TEXT_REPORT"
echo "WARN: $WARN" | tee -a "$TEXT_REPORT"



STATUS="PASS"


if [[ "$FAIL" -gt 0 ]]
then

STATUS="FAIL"

fi



cat > "$JSON_REPORT" <<EOF
{
 "framework":"Terminal Academy Framework",
 "analysis_date":"$(date -Iseconds)",

 "results":{

   "status":"$STATUS",

   "passed":$PASS,

   "failed":$FAIL,

   "warnings":$WARN

 },

 "reports":{

   "text":"reports/build-analysis.txt",

   "json":"reports/build-analysis.json"

 }

}
EOF



echo
echo "==============================================="
echo " BUILD ANALYSIS COMPLETE"
echo "==============================================="

echo

echo "Status: $STATUS"

echo "Report:"
echo "$TEXT_REPORT"

echo "JSON:"
echo "$JSON_REPORT"


if [[ "$STATUS" == "FAIL" ]]
then

exit 1

fi
