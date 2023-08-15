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
    
    folder_path="${root}/archives/"
    
    # Check if folder exists
    if [ ! -d "$folder_path" ]; then
        echo "Folder does not exist"
        return 1
    fi
    
    # Get the list of files in the folder
    files=$(ls "$folder_path")
    
    # Check if folder is empty
    if [ -z "$files" ]; then
        echo "Folder is empty"
        return 0
    fi
    
    # Print table header
    printf "%-20s %-10s\n" "Filename" "Size"
    
    # Loop through each file in the folder
    for file in $files; do
        # Get the filename without extension
        filename=$(basename "$file")
        filename_no_ext="${filename%.*}"
        
        # Get the file size
        size=$(du -sh "$folder_path/$file" | awk '{print $1}')
        
        # Print the filename and size in table format
        printf "%-20s %-10s\n" "$filename_no_ext" "$size"
    done
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

restore() {
    read -p "Enter the backup directory: " backup
    
    if [ -d "$backup" ]; then
        read -p "Are you 100% sure you want to restore your system? (y/N): " choice
        
        case "$choice" in
            [Yy])
                # rsync --exclude="${root}" "${backup-folder}" /
                echo "Restoring from backup: $backup"
            ;;
            [Nn])
                echo "Operation canceled."
            ;;
            *)
                echo "Operation canceled."
            ;;
        esac
    else
        echo "Backup directory not found: $backup"
    fi
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
        -D|--clean-all)
            clean_everything
            shift
        ;;
        -d|--clean-archives)
            clean_archives
            shift
        ;;
        -r|--restore)
            restore
            shift
        ;;
        *)
            echo "show help"
            exit 1
        ;;
    esac
done
