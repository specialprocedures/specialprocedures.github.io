#!/bin/bash
# Compress all images in static/ to be under 700KB

MAX_SIZE=716800  # 700KB in bytes
STATIC_DIR="/home/ian/Projects/specialprocedures.github.io/static"

compress_image() {
    local file="$1"
    local size=$(stat -c%s "$file")
    
    if [ "$size" -le "$MAX_SIZE" ]; then
        return 0
    fi
    
    echo "Processing: $file ($(numfmt --to=iec $size))"
    
    local ext="${file##*.}"
    local lower_ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
    
    # For PNG files, convert to JPG for better compression
    if [ "$lower_ext" = "png" ]; then
        local jpg_file="${file%.*}.jpg"
        magick "$file" -quality 85 "$jpg_file"
        local new_size=$(stat -c%s "$jpg_file")
        
        # Try lower quality if still too big
        local quality=85
        while [ "$new_size" -gt "$MAX_SIZE" ] && [ "$quality" -gt 30 ]; do
            quality=$((quality - 10))
            magick "$file" -quality $quality "$jpg_file"
            new_size=$(stat -c%s "$jpg_file")
        done
        
        # If still too big, resize
        if [ "$new_size" -gt "$MAX_SIZE" ]; then
            magick "$file" -quality $quality -resize "1920x1920>" "$jpg_file"
            new_size=$(stat -c%s "$jpg_file")
        fi
        
        if [ "$new_size" -gt "$MAX_SIZE" ]; then
            magick "$file" -quality $quality -resize "1280x1280>" "$jpg_file"
            new_size=$(stat -c%s "$jpg_file")
        fi
        
        if [ "$new_size" -le "$MAX_SIZE" ]; then
            rm "$file"
            echo "  -> Converted to JPG: $(numfmt --to=iec $new_size)"
        else
            echo "  -> WARNING: Could not reduce below 700KB"
        fi
    else
        # For JPG/JPEG files
        local quality=85
        local tmp_file=$(mktemp --suffix=".jpg")
        
        magick "$file" -quality $quality "$tmp_file"
        local new_size=$(stat -c%s "$tmp_file")
        
        while [ "$new_size" -gt "$MAX_SIZE" ] && [ "$quality" -gt 30 ]; do
            quality=$((quality - 10))
            magick "$file" -quality $quality "$tmp_file"
            new_size=$(stat -c%s "$tmp_file")
        done
        
        # If still too big, resize
        if [ "$new_size" -gt "$MAX_SIZE" ]; then
            magick "$file" -quality $quality -resize "1920x1920>" "$tmp_file"
            new_size=$(stat -c%s "$tmp_file")
        fi
        
        if [ "$new_size" -gt "$MAX_SIZE" ]; then
            magick "$file" -quality $quality -resize "1280x1280>" "$tmp_file"
            new_size=$(stat -c%s "$tmp_file")
        fi
        
        if [ "$new_size" -le "$MAX_SIZE" ]; then
            mv "$tmp_file" "$file"
            echo "  -> Compressed: $(numfmt --to=iec $new_size)"
        else
            rm "$tmp_file"
            echo "  -> WARNING: Could not reduce below 700KB"
        fi
    fi
}

export -f compress_image
export MAX_SIZE
export STATIC_DIR

find "$STATIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -size +700k -print0 | while IFS= read -r -d '' file; do
    compress_image "$file"
done

echo ""
echo "Done! Checking for remaining oversized images..."
remaining=$(find "$STATIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -size +700k | wc -l)
echo "Remaining images over 700KB: $remaining"
