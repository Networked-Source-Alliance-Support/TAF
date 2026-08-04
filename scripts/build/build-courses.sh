#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

COURSE_DIR="$ROOT_DIR/courses/registry"

echo "=============================================="
echo " Terminal Academy Course Builder"
echo " Building: GitHub Registry Academy"
echo "=============================================="

mkdir -p "$COURSE_DIR/lessons"
mkdir -p "$COURSE_DIR/labs"


echo "[+] Creating course metadata"


cat > "$COURSE_DIR/course.json" <<'EOF'
{
  "id": "registry",
  "title": "GitHub Registry Academy",
  "version": "1.0.0",
  "description": "Learn GitHub Container Registry, OCI metadata, npm package architecture, and supply chain security.",
  "author": "Terminal Academy",
  "level": "intermediate",

  "modules": [
    {
      "id": "001",
      "type": "lesson",
      "title": "Container Registry Fundamentals"
    },
    {
      "id": "002",
      "type": "lesson",
      "title": "OCI Metadata and Image Provenance"
    },
    {
      "id": "003",
      "type": "lesson",
      "title": "Scoped npm Registry Architecture"
    },
    {
      "id": "004",
      "type": "lesson",
      "title": "Registry Security Auditing"
    }
  ]
}
EOF


echo "[+] Creating course runtime"


cat > "$COURSE_DIR/course.sh" <<'EOF'
#!/usr/bin/env bash


course_init(){

echo "Loading GitHub Registry Academy"

}


course_info(){

jq . "$COURSE_DIR/course.json"

}
EOF



echo "[+] Creating lessons"



cat > "$COURSE_DIR/lessons/lesson-001.sh" <<'EOF'
#!/usr/bin/env bash


run_lesson_impl(){

header

echo "
LESSON 001
Container Registry Fundamentals

Topics:

✓ GitHub Container Registry (ghcr.io)
✓ OCI compatibility
✓ Image storage
✓ Authentication models

"

pause

}
EOF



cat > "$COURSE_DIR/lessons/lesson-002.sh" <<'EOF'
#!/usr/bin/env bash


run_lesson_impl(){

header

echo "
LESSON 002
OCI Metadata and Image Provenance

Topics:

✓ OCI labels
✓ Source linking
✓ Image ownership
✓ Supply chain tracking

Example:

LABEL org.opencontainers.image.source=https://github.com/example/project

"

pause

}
EOF



cat > "$COURSE_DIR/lessons/lesson-003.sh" <<'EOF'
#!/usr/bin/env bash


run_lesson_impl(){

header

echo "
LESSON 003
Scoped npm Registry Architecture

Topics:

✓ npm scopes
✓ Package namespaces
✓ Dependency protection
✓ Registry routing


Example:

@organization/package

"

pause

}
EOF



cat > "$COURSE_DIR/lessons/lesson-004.sh" <<'EOF'
#!/usr/bin/env bash


run_lesson_impl(){

header

echo "
LESSON 004
Registry Security Auditing

Topics:

✓ Package permissions
✓ Dependency auditing
✓ Supply-chain security
✓ Secure publishing


Command example:

npm audit --scope=@namespace

"

pause

}
EOF



echo "[+] Creating labs"



cat > "$COURSE_DIR/labs/lab-001.sh" <<'EOF'
#!/usr/bin/env bash


run_lab_impl(){

header


echo "
LAB 001

Docker Metadata Annotation

Create:

org.opencontainers.image.source

"



read -rp "Docker LABEL command: " answer


if validate_contains "$answer" "org.opencontainers.image.source"
then

success "OCI metadata validated"

else

error "Missing OCI source annotation"

fi


pause

}
EOF



cat > "$COURSE_DIR/labs/lab-002.sh" <<'EOF'
#!/usr/bin/env bash


run_lab_impl(){

header


echo "
LAB 002

npm Registry Scope Configuration


Create:

@organization:registry=https://npm.pkg.github.com

"



read -rp ".npmrc entry: " answer


if validate_contains "$answer" "npm.pkg.github.com"
then

success "Registry scope configured"

else

error "Invalid registry configuration"

fi


pause

}
EOF



echo "[+] Creating quiz"



cat > "$COURSE_DIR/quiz.json" <<'EOF'
{
"title":"GitHub Registry Academy Assessment",

"questions":[

{
"question":"What registry does GitHub use for containers?",
"answer":"ghcr.io"
},

{
"question":"What does OCI stand for?",
"answer":"Open Container Initiative"
},

{
"question":"What prefix identifies scoped npm packages?",
"answer":"@"
},

{
"question":"What file configures npm registry routing?",
"answer":".npmrc"
}

]

}
EOF



chmod +x \
"$COURSE_DIR/course.sh" \
"$COURSE_DIR/lessons/"*.sh \
"$COURSE_DIR/labs/"*.sh



echo
echo "=============================================="
echo " Course build complete"
echo "=============================================="

echo
echo "Generated:"
echo "$COURSE_DIR"

find "$COURSE_DIR" -type f | sort
