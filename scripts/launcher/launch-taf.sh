#!/usr/bin/env bash

set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

BUILD_DIR="$ROOT_DIR/scripts/build"
AUDIT_DIR="$ROOT_DIR/scripts/audit"

APP="$ROOT_DIR/academy.sh"


echo "================================================"
echo " Terminal Academy Framework Launcher"
echo "================================================"


#
# STEP 1
# BUILD EVERYTHING
#

echo
echo "[1/4] Building complete framework..."

"$BUILD_DIR/build-all.sh"



#
# STEP 2
# VERIFY BUILD
#

echo
echo "[2/4] Running framework audit..."

"$AUDIT_DIR/analyze-build.sh"



#
# STEP 3
# COMPILE APPLICATION WRAPPER
#

echo
echo "[3/4] Compiling TAF executable..."



cat > "$APP" <<'EOF'
#!/usr/bin/env bash

set -euo pipefail


BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$BASE_DIR/core/bootstrap.sh"
source "$BASE_DIR/core/ui.sh"
source "$BASE_DIR/core/state.sh"
source "$BASE_DIR/core/course.sh"
source "$BASE_DIR/core/quiz.sh"
source "$BASE_DIR/core/validator.sh"
source "$BASE_DIR/core/certificate.sh"
source "$BASE_DIR/core/logger.sh"



bootstrap

init_state



main_menu(){


while true

do


header


echo "
TERMINAL ACADEMY FRAMEWORK

[1] List Courses
[2] Registry Academy
[3] View Progress
[4] Generate Certificate
[5] Exit

"


read -rp "Select: " choice



case "$choice" in


1)

list_courses

pause

;;


2)

load_course registry

echo

echo "Registry Academy"

echo

echo "Lessons:"
echo "001 Container Registry"
echo "002 OCI Metadata"
echo "003 npm Architecture"
echo "004 Security"


read -rp "Lesson ID: " id


run_lesson "$id"


;;


3)

show_progress

pause

;;


4)

generate_certificate

pause

;;


5)

exit 0

;;


*)

error "Invalid option"

;;

esac


done


}



main_menu
EOF



chmod +x "$APP"



#
# STEP 4
# OPEN NEW WINDOW
#

echo
echo "[4/4] Launching Terminal Academy..."



launch_terminal(){


if command -v gnome-terminal >/dev/null 2>&1
then

gnome-terminal \
-- bash -c "cd '$ROOT_DIR' && ./academy.sh; exec bash"


elif command -v x-terminal-emulator >/dev/null 2>&1
then

x-terminal-emulator \
-e bash -c "cd '$ROOT_DIR' && ./academy.sh; exec bash"



elif command -v wt.exe >/dev/null 2>&1
then

wt.exe \
bash -lc "cd '$ROOT_DIR' && ./academy.sh"



elif command -v konsole >/dev/null 2>&1
then

konsole \
-e bash -c "cd '$ROOT_DIR' && ./academy.sh; exec bash"



else

echo
echo "No supported terminal launcher detected."
echo
echo "Run manually:"
echo
echo "./academy.sh"

fi


}



launch_terminal



echo
echo "================================================"
echo " TAF launched successfully"
echo "================================================"
