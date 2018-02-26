#!/bin/bash
find ./ -name ".DS_Store" -depth -exec rm {} \;

for file in `ls ./projects`
    do
      if [[ -d "./projects/$file" ]]; then
        mkdir -p "docs/debs/$file"
        dpkg-deb -bZgzip "./projects/$file" "docs/debs/$file"
			fi
    done

dpkg-scanpackages -m ./docs/debs > ./docs/Packages
bzip2 -fks ./docs/Packages
