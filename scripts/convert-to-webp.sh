#!/bin/bash
# Convert all images in static/ to WebP format

STATIC_DIR="/home/ian/Projects/specialprocedures.github.io/static"
MAX_SIZE=716800  # 700KB in bytes

convert_to_webp() {
    local file="$1"
    local webp_file="${file%.*}.webp"
    
    echo "Converting: $file"
    
    # Convert to WebP with quality 85
    local quality=85
    magick "$file" -quality $quality "$webp_file"
    local new_size=$(stat -c%s "$webp_file")
    
    # Reduce quality if still over 700KB
    while [ "$new_size" -gt "$MAX_SIZE" ] && [ "$quality" -gt 30 ]; do
        quality=$((quality - 10))
        magick "$file" -quality $quality "$webp_file"
        new_size=$(stat -c%s "$webp_file")
    done
    
    # Resize if still too big
    if [ "$new_size" -gt "$MAX_SIZE" ]; then
        magick "$file" -quality $quality -resize "1920x1920>" "$webp_file"
        new_size=$(stat -c%s "$webp_file")
    fi
    
    if [ "$new_size" -gt "$MAX_SIZE" ]; then
        magick "$file" -quality $quality -resize "1280x1280>" "$webp_file"
        new_size=$(stat -c%s "$webp_file")
    fi
    
    # Remove original file
    rm "$file"
    echo "  -> $(numfmt --to=iec $new_size)"
}

export -f convert_to_webp
export MAX_SIZE

# Convert JPG, JPEG, PNG files
find "$STATIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | while IFS= read -r -d '' file; do
    convert_to_webp "$file"
done

echo ""
echo "Done! Converted all images to WebP."
echo "Total WebP files: $(find "$STATIC_DIR" -type f -iname "*.webp" | wc -l)"
