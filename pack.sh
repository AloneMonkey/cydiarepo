#!/bin/bash
for file in `ls ./source`
    do
      if [[ -d "./source/$file" ]]; then
        rm -rf "./projects/$file"
        mkdir -p "./projects/$file"
        cp -rf "./source/$file/$file/Package/" "./projects/$file/"
        echo "successful copy $file to projects folder"
			fi
    done

cd ./docs && ./gen.sh
