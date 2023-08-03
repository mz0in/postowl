#!/bin/sh

# Script to run when deploying to fly.io
# This creates or migrates the database on your fly volume and then starts the app
set -e

FOLDER=/app/data
if [ ! -d "$FOLDER" ]
then
    echo "$FOLDER is not a directory, initializing database" 
    mkdir /app/data
    touch /app/data/db.sqlite3
fi

sqlite3 /app/data/db.sqlite3 < /app/scripts/schema.sql
node -r dotenv/config /app/scripts/start-app.js
