#!/bin/bash
# Generate Hugo page content from AI image folders
# Usage: ./scripts/generate-ai-gallery.sh [source_folder] [output_file] [columns]

SOURCE_FOLDER="${1:-static/images/ai}"
OUTPUT_FILE="${2:-content/docs/ai/trip.md}"
GRID_COLS="${3:-3}"

cd "$(dirname "$0")/.." || exit 1

# Create output file with frontmatter if it doesn't exist
if [ ! -f "$OUTPUT_FILE" ]; then
    mkdir -p "$(dirname "$OUTPUT_FILE")"
    cat > "$OUTPUT_FILE" << 'EOF'
---
title: "AI Gallery"
weight: 10
---

EOF
fi

# Append galleries for each subfolder
for dir in "$SOURCE_FOLDER"/*/; do
    [ -d "$dir" ] || continue
    
    folder_name=$(basename "$dir")
    relative_path="${SOURCE_FOLDER#static/}/$folder_name"
    
    # Read prompt.txt if it exists
    if [ -f "$dir/prompt.txt" ]; then
        prompt_text=$(cat "$dir/prompt.txt" | tr -d '\n' | sed 's/%$//')
        echo "" >> "$OUTPUT_FILE"
        echo "*$prompt_text*" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
    
    # Add grid shortcode
    echo "{{< grid dir=\"$relative_path\" columns=\"$GRID_COLS\" >}}" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "Generated: $OUTPUT_FILE"
