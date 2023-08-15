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

clean_everything() {
    rm -rf ${root}/
}

clean_archives() {
    # Prompt for confirmation
    read -p "Are you sure you want to delete the archives directory? (y/n): " choice
    
    case "$choice" in
        [Yy])
            rm -rf "${root}/archives/"
            echo "Archives directory deleted."
        ;;
        [Nn])
            echo "Operation canceled."
        ;;
        *)
            echo "Invalid choice. Operation canceled."
        ;;
    esac
}

if [ $# -eq 0 ]; then
    echo "No arguments provided"
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--create)
            snapshot
            shift
        ;;
        -R|--clean-all)
            clean_everything
            shift
        ;;
        -r|--clean-archives)
            clean_archives
            shift
        ;;
        *)
            echo "show help"
            exit 1
        ;;
    esac
done

# echo "${current_folder}"
# echo "${root}"
# echo "${folder}"
# echo "rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude='${folder}' / '${current_folder}'"
# echo "tar cvf '${root}/archives/${folder}.tar' '${current_folder}'"
