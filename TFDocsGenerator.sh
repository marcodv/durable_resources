#!/bin/bash

# This script is used to generate Terraform modules documentation in md format
# as last step during a pipeline execution
#
# The script will iterate over all the folders in the project and for each of those
# it use terraform-docs to generate the markdown file.
# Once done that, will use mkdocs to displey them inside the project's GitLab page 
# 
# IMPORTANT: You need to run this script in local for generate the md pages and later the pipeline will do the rest ;)

declare -a dir_list=("environments" "modules")

root_project_dir=$(pwd)
for dir in "${dir_list[@]}"
do
   
   cd "$dir"
   sub_dir=(`ls -d */`)
   # Looping over subfolders
   for subdir in "${sub_dir[@]}"
     do
      subdir=${subdir%?}
      cd $root_project_dir/$dir/$subdir
      sub_modules_dir=(`find . -mindepth 0 -type d | grep -v ".terraform"`)
     for subModulesDir in "${sub_modules_dir[@]}"
       do
        secondLevelDir=${subModulesDir:2}
        cd $root_project_dir/$dir/$subdir/$secondLevelDir
        # check if main.tf exists. If yes created docs, else skip this folder
        if [ ! -f "$root_project_dir/$dir/$subdir/$secondLevelDir/main.tf" ]; then
          echo $root_project_dir/$dir/$subdir/$secondLevelDir
        fi
        #terraform-docs markdown table --output-file "${subdir}.md" --output-mode inject "$root_project_dir/$dir/$subdir/$secondLevelDir"
        #mv $root_project_dir/$dir/$subdir/$secondLevelDir/"${subdir}".md $root_project_dir/docs/
     done 
   done
   cd $root_project_dir 

done
