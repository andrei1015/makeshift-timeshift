#!/bin/bash
root='/backups'
folder=$(date +'%Y-%m-%d-%H-%M-%S')
current_folder="${root}/${folder}"

snapshot() {
    mkdir -p "${root}/archives"
    rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude="${root}" / "${current_folder}"
    tar cvf "${root}/archives/${folder}.tar" "${current_folder}"
    rm -rf "${current_folder}"
}

snapshot

# echo "${current_folder}"
# echo "${root}"
# echo "${folder}"
# echo "rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude='${folder}' / '${current_folder}'"
# echo "tar cvf '${root}/archives/${folder}.tar' '${current_folder}'"
