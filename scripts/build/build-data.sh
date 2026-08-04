#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd)"

DATA_DIR="$ROOT_DIR/data"

echo "=============================================="
echo " Building Terminal Academy Data Layer"
echo "=============================================="


mkdir -p "$DATA_DIR/schemas"


cat > "$DATA_DIR/courses.json" <<'EOF'
{
  "framework": "Terminal Academy Framework",
  "version": "1.0.0",

  "courses": [
    {
      "id": "registry",
      "path": "courses/registry",
      "title": "GitHub Registry Academy"
    }
  ]
}
EOF



cat > "$DATA_DIR/schemas/certificate.schema.json" <<'EOF'
{
 "$schema":"https://json-schema.org/draft/2020-12/schema",

 "title":"Terminal Academy Certificate",

 "type":"object",

 "required":[
   "type",
   "protocol",
   "achievement",
   "integrity"
 ],

 "properties":{

   "type":{
     "type":"string"
   },

   "protocol":{
     "type":"string"
   },

   "achievement":{
     "type":"object"
   },

   "integrity":{
     "type":"object",
     "required":[
       "algorithm",
       "hash"
     ]
   }

 }

}
EOF


echo "Data layer created."
