#!/bin/bash
root='/backups'
folder=$(date +'%Y-%m-%d-%H-%M-%S')
current_folder="${root}/${folder}"

# FUNCTIONS
# -------------------------------------------------------

snapshot() {
    mkdir -p "${root}/archives"
    rsync -aAXHv --mkpath --include-from='include.list' --exclude-from='exclude.list' --exclude="${root}" / "${current_folder}"
    tar cvf "${root}/archives/${folder}.tar" "${current_folder}"
    rm -rf "${current_folder}"
}

list(){
    # if [ -d "${root}/archives/" ]; then
    #     ls -aAsh --si "${root}/archives/"
    # else
    #     echo "Archives folder does not exist."
    # fi
    
    local directory="${root}/archives/"
    
    if [ ! -d "$directory" ]; then
        echo "Archives folder does not exist"
        return 1
    fi
    
    echo "----------------------------------------"
    echo "Name        | Type       | Size (bytes)"
    echo "----------------------------------------"
    for file in "$directory"/*; do
        if [ -f "$file" ]; then
            file_type="File"
            elif [ -d "$file" ]; then
            file_type="Directory"
        else
            file_type="Unknown"
        fi
        
        file_size=$(du -b "$file" | cut -f1)
        file_name=$(basename "$file")
        
        printf "%-12s | %-10s | %12s\n" "$file_name" "$file_type" "$file_size"
    done
    echo "----------------------------------------"
}

clean_everything() {
    read -p "Are you sure you want to perform a full cleanup of backups? (y/N): " choice
    
    case "$choice" in
        [Yy])
            rm -rf "${root}/*"
            echo "Archives directory deleted."
        ;;
        [Nn])
            echo "Operation canceled."
        ;;
        *)
            echo "Operation canceled."
        ;;
    esac
    rm -rf ${root}/*
}

clean_archives() {
    read -p "Are you sure you want to delete the archives directory? (y/N): " choice
    
    case "$choice" in
        [Yy])
            rm -rf "${root}/archives/*"
            echo "Archives directory deleted."
        ;;
        [Nn])
            echo "Operation canceled."
        ;;
        *)
            echo "Operation canceled."
        ;;
    esac
}


# MENU
# -------------------------------------------------------

if [ $# -eq 0 ]; then
    echo "No arguments provided"
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--create)
            snapshot
            shift
        ;;
        -l|--list)
            list
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
