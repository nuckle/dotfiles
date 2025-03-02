ZDOTDIR=/$HOME/.config/zsh

mute_video() {
    if [ -z "$1" ]; then
        echo "Usage: mute_video <input_video>"
        return 1
    fi
    ffmpeg -i "$1" -c copy -an "muted_$1"
}

# Use lf to switch directories 
lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Convert video to gif file.
# Usage: video2gif video_file (scale) (fps)
video2gif() {
	ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
	ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
	rm "${1}.png"
}

# Make video playable by applying chroma subsampling
# Usage: fixvideop video_file output_file

fixvideop() {
	ffmpeg -i "${1}" -c:v libx264 -profile:v baseline -c:a aac -ar 44100 -ac 2 -b:a 128k -vf format=yuv420p "${2}"
}

convert_favicon() { for size in 32x32 16x16 48x48 192x192 167x167 180x180; do magick convert $1 -resize $size favicon-$size.png; done }

pwdcp () {
	echo -n "$PWD" | xclip -selection clipboard
}
