#!/bin/bash
# Converts a .docx into a raw markdown draft + a clean images/ folder.
# This is the deterministic first pass only — Claude does the cleanup
# and restructuring afterward by reading and rewriting draft.md.
#
# Usage: extract.sh <input.docx> <output_dir>
set -e

INPUT="$1"
OUTDIR="$2"

if [ -z "$INPUT" ] || [ -z "$OUTDIR" ]; then
  echo "Usage: extract.sh <input.docx> <output_dir>"
  exit 1
fi

mkdir -p "$OUTDIR/images"
TMPMEDIA=$(mktemp -d)

pandoc "$INPUT" -t markdown --wrap=none --extract-media="$TMPMEDIA" -o "$OUTDIR/draft.md"

# pandoc nests extracted images under <TMPMEDIA>/media/*; flatten into OUTDIR/images/
if [ -d "$TMPMEDIA/media" ]; then
  cp "$TMPMEDIA"/media/* "$OUTDIR/images/" 2>/dev/null || true
fi
rm -rf "$TMPMEDIA"

# Rewrite image references in draft.md to point at ./images/<file> instead of the temp path
python3 - "$OUTDIR/draft.md" <<'PYEOF'
import re, sys
path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    text = f.read()
# Matches ![...](anything/media/filename.ext ...) and rewrites the src to images/filename.ext
text = re.sub(r'(!\[[^\]]*\]\()[^)]*/media/([^)\s]+)', r'\1images/\2', text)
with open(path, "w", encoding="utf-8") as f:
    f.write(text)
PYEOF

echo "Draft markdown: $OUTDIR/draft.md"
echo "Images folder:  $OUTDIR/images/"
ls "$OUTDIR/images" 2>/dev/null | sed 's/^/  - /'
