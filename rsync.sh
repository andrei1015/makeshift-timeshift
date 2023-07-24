#!/bin/bash
root='/backups'
folder=$(date +'%Y-%m-%d-%H-%M-%S')
current_folder="${root}/${folder}"

# Uncomment these lines for debugging if needed
# echo "${current_folder}"
# echo "${root}"
# echo "${folder}"

rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude="${root}" / "${current_folder}"
tar cvf "${root}/archives/${folder}.tar" "${current_folder}"

# echo "rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude='${folder}' / '${current_folder}'"
# echo "tar cvf '${root}/archives/${folder}.tar' '${current_folder}'" 