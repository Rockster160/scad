# This script assumes you have ImageMagick installed and accessible via the `convert` command.

require "fileutils"

svg_path = ARGV[0]
png_path = svg_path.gsub(/\.svg$/, ".png")

# Use ImageMagick to convert SVG to PNG (raster image)
# system("convert #{svg_path} -resize 50x -threshold 50% -negate #{png_path}")
system("convert #{svg_path} -resize 200x -threshold 50% -negate #{png_path}")
