#!/bin/sh
cd /home/mclarke/Documents/bioinfo-utils/
now=$( date ) 
git add .
git commit -m "Weekly autocommit for $now"
git push

