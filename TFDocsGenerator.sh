#!/bin/bash

# This script is used to generate Terraform modules documentation in md format
# as last step during a pipeline execution
#
# The script will iterate over all the folders in the project and for each of those
# it use terraform-docs to generate the markdown file.
# Once done that, will use mkdocs to displey them inside the project's GitLab page 
# 
# IMPORTANT: You need to run this script in local for generate the md pages and later the pipeline will do the rest ;)

# Iterate over environments
root_project_dir=$(pwd)   
cd "$root_project_dir/environments"
sub_dir=(`ls -d */`)
# Looping over subfolders
for subdir in "${sub_dir[@]}"
  do
    subdir=${subdir%?}
    cd $root_project_dir/$dir/environments/$subdir
    terraform-docs markdown table --output-file "${subdir}.md" --output-mode inject "$root_project_dir/environments/$dir/$subdir"
    mv "$root_project_dir/environments/$dir/$subdir/"${subdir}".md" $root_project_dir/docs/
done

cd "$root_project_dir/modules"
top_dir=( $(ls .) )
for topdir in "${top_dir[@]}"
  do
    cd "$root_project_dir/modules/$topdir"
    sub_dir=( $(find . -mindepth 1 -type d) )
    for subdir in "${sub_dir[@]}"
      do
      dir=${subdir:2}
      cd $dir
      if [ -e "main.tf" ]; then
        terraform-docs markdown table --output-file "$root_project_dir/modules/$topdir/${dir}.md" --output-mode inject "$root_project_dir/modules/$topdir/$dir"
        mv "$root_project_dir/modules/$topdir/${dir}.md" $root_project_dir/docs/ 
      fi
      cd "$root_project_dir/modules/$topdir/" 
    done
  done
