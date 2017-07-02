#!/bin/bash

scriptDir="$HOME/environment"
configPathsFileName='configPaths.txt'

for configPath in `cat "$configPathsFileName"`; do
    expConfigPath="${configPath/#\~/$HOME}"
    expBackupConfigPath="$expConfigPath.backup"

    if stat "$expConfigPath" &> /dev/null; then
        if stat "$expBackupConfigPath" &> /dev/null; then
            echo "Backup $configPath.backup already exists. Not linking $configPath."
            continue
        fi

        echo "Backuping $configPath"
        mv "$expConfigPath" "$expBackupConfigPath"
    fi

    echo "Linking $configPath"
    ln -s "$scriptDir/`basename "$expConfigPath"`" "$expConfigPath"
done
