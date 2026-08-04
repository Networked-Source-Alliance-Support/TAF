#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

CORE_DIR="$ROOT_DIR/core"

echo "=============================================="
echo " Terminal Academy Core Builder"
echo "=============================================="

mkdir -p "$CORE_DIR"

echo "[+] Building core modules..."


cat > "$CORE_DIR/bootstrap.sh" <<'EOF'
#!/usr/bin/env bash

bootstrap(){

    mkdir -p "$BASE_DIR/certificates"
    mkdir -p "$HOME/.terminal-academy"

    if ! command -v jq >/dev/null 2>&1; then
        echo "Warning: jq is required for JSON state management."
    fi

}
EOF



cat > "$CORE_DIR/ui.sh" <<'EOF'
#!/usr/bin/env bash


CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
WHITE='\033[1;37m'
NC='\033[0m'


header(){

clear

echo -e "${CYAN}"
echo "==============================================="
echo "       TERMINAL ACADEMY FRAMEWORK"
echo "==============================================="
echo -e "${NC}"

}


pause(){

echo
read -rp "Press ENTER to continue..."

}


success(){

echo -e "${GREEN}[SUCCESS]${NC} $1"

}


error(){

echo -e "${RED}[ERROR]${NC} $1"

}


show_help(){

cat <<EOF

Terminal Academy Framework

Commands:

academy courses

academy lesson <course> <id>

academy lab <course> <id>

academy quiz <course>

academy progress

academy certificate

academy install <course>

academy reset

academy version


EOF

}


show_version(){

echo "Terminal Academy Framework"

cat "$BASE_DIR/VERSION"

}
EOF



cat > "$CORE_DIR/state.sh" <<'EOF'
#!/usr/bin/env bash


STATE_DIR="$HOME/.terminal-academy"

STATE_FILE="$STATE_DIR/state.json"



init_state(){

mkdir -p "$STATE_DIR"


if [[ ! -f "$STATE_FILE" ]]; then

cat > "$STATE_FILE" <<JSON
{
"user":"Learner",
"courses":{}
}
JSON

fi

}



update_state(){

local query="$1"


tmp=$(mktemp)


jq "$query" \
"$STATE_FILE" > "$tmp"


mv "$tmp" "$STATE_FILE"

}



set_progress(){

COURSE="$1"
ITEM="$2"


update_state \
".courses[\"$COURSE\"].$ITEM=true"

}



show_progress(){

jq . "$STATE_FILE"

}



reset_state(){

rm -rf "$STATE_DIR"

echo "State reset."

init_state

}
EOF



cat > "$CORE_DIR/course.sh" <<'EOF'
#!/usr/bin/env bash


COURSES_DIR="$BASE_DIR/courses"



load_course(){

COURSE_ID="$1"

COURSE_DIR="$COURSES_DIR/$COURSE_ID"


if [[ ! -f "$COURSE_DIR/course.json" ]]; then

error "Course not found: $COURSE_ID"

exit 1

fi

}



list_courses(){

header

echo "Installed Courses"
echo


for course in "$COURSES_DIR"/*
do

if [[ -d "$course" ]]; then

jq -r '.title' "$course/course.json"

fi

done

}



run_lesson(){

ID="$1"

LESSON_FILE="$COURSE_DIR/lessons/lesson-$ID.sh"


if [[ ! -f "$LESSON_FILE" ]]; then

error "Lesson missing"

exit 1

fi


source "$LESSON_FILE"

run_lesson_impl


set_progress "$COURSE_ID" "lesson_$ID"

}



run_lab(){

ID="$1"

LAB_FILE="$COURSE_DIR/labs/lab-$ID.sh"


source "$LAB_FILE"

run_lab_impl


set_progress "$COURSE_ID" "lab_$ID"

}



install_course(){

SOURCE="$1"


cp -r "$SOURCE" "$COURSES_DIR/"


success "Course installed"

}
EOF



cat > "$CORE_DIR/quiz.sh" <<'EOF'
#!/usr/bin/env bash


run_quiz(){

QUIZ="$COURSE_DIR/quiz.json"


TOTAL=$(jq '.questions | length' "$QUIZ")

SCORE=0


for ((i=0;i<TOTAL;i++))
do


QUESTION=$(jq -r ".questions[$i].question" "$QUIZ")

ANSWER=$(jq -r ".questions[$i].answer" "$QUIZ")


echo
echo "$QUESTION"

read -rp "> " USER


if [[ "$USER" == "$ANSWER" ]]
then

success "Correct"

((SCORE++))

else

error "Incorrect"

fi


done


echo
echo "Score: $SCORE/$TOTAL"


set_progress "$COURSE_ID" "quiz_score=$SCORE"

}
EOF



cat > "$CORE_DIR/validator.sh" <<'EOF'
#!/usr/bin/env bash


validate_contains(){

INPUT="$1"

EXPECTED="$2"


if [[ "$INPUT" == *"$EXPECTED"* ]]
then

return 0

fi


return 1

}



validate_file(){

FILE="$1"


[[ -f "$FILE" ]]

}
EOF



cat > "$CORE_DIR/certificate.sh" <<'EOF'
#!/usr/bin/env bash



generate_certificate(){

mkdir -p "$BASE_DIR/certificates"


DATE=$(date -I)

CERT="$BASE_DIR/certificates/certificate-$DATE.json"



cat > "$CERT" <<JSON
{
"type":"education_certificate",
"protocol":"RAIP-1.0",
"framework":"Terminal Academy Framework",
"date":"$DATE"
}
JSON



HASH=$(sha256sum "$CERT" | awk '{print $1}')


echo "$HASH" > "$CERT.sha256"


success "Certificate generated"

echo "$CERT"

}
EOF



cat > "$CORE_DIR/logger.sh" <<'EOF'
#!/usr/bin/env bash


LOG_DIR="$HOME/.terminal-academy"

LOG_FILE="$LOG_DIR/activity.log"



log(){

mkdir -p "$LOG_DIR"


echo "[$(date '+%F %T')] $1" >> "$LOG_FILE"

}
EOF



chmod +x "$CORE_DIR"/*.sh


echo
echo "=============================================="
echo " Core build complete"
echo "=============================================="
