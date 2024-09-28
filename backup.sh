#!bin/bash

rclone bisync Backups/ proton:Backups --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only --resilient -MvP --fix-case --resync
