#!/bin/bash

# Modified from:
# https://github.com/flutter/photobooth/blob/main/tool/generate_asset_metadata.sh
# 
# Script used to analyze bundled assets and generate a dart file which contains
# the relevant metadata needed at runtime without forcing the application to
# download the assets.
#
# Usage:
# sh tools/echo_asset_metadata.sh > lib/assets.g.dart

set -e

echo "// GENERATED CODE - DO NOT MODIFY BY HAND"
echo ""
echo "import 'package:flutter/widgets.dart';"
echo ""
echo "class Asset {"
echo "  const Asset({"
echo "    required this.name,"
echo "    required this.path,"
echo "    required this.size,"
echo "  });"
echo ""
echo "  final String name;"
echo "  final String path;"
echo "  final Size size;"
echo "}"
echo ""
echo "class Assets {"
echo "  const Assets._();"
echo ""

props=(assets/images/*.png)

for prop in "${props[@]}"
do
    width=$(sips -g pixelWidth $prop | tail -n1 | cut -d" " -f4)
    height=$(sips -g pixelHeight $prop | tail -n1 | cut -d" " -f4)    
    propName=$(basename "${prop%.*}")

    # Replace spaces and dashes with underscores
    name=${propName// /_}
    name=${name//-/_}

    # Convert to snake case for dart
    name=$(echo "$name" | perl -nE 'say lcfirst join "", map {ucfirst lc} split /[^[:alnum:]]+/')

    echo "  static const $name = Asset("
    echo "    name: '$propName',"
    echo "    path: '$prop',"
    echo "    size: const Size($width, $height),"
    echo "  );"
done

echo "}"
