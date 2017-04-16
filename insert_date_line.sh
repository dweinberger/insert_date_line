#!/bin/bash

#	This works with OSX. The "sed" statement is unique to Mac
#	apparently.
#
#	It goes through a directory looking for *.txt files.
#
#	It looks in each one for a line that contains "NOTESDATE="
#
#	If it finds one, it adds a human-readable version of
#	the last-modified date of that file.
#
#	If it doesn't find that line, it adds it.
#
#	It will look like this: NOTESDATE=2016-04-30
#
#	It then restores the file to its original last-modified date
#	rather than the current date (because it was just re-saved).
#
#	It then deletes the backup automatically made
#
#	I cobbled it together pretty blindly using
#	Stackoverflow and other Web sources. I don't know how
#	to write shell programs, and I'm sure it shows.
#
#	It's of course open source. Use it any way you like,
#	so long as you don't rely on it.
#
#	NOTE: THIS SCRIPT OVERWRITES FILES YOU CARE ABOUT
#	SO BACKUP EVERYTHING FIRST, AND THINK ABOUT WHETHER
#	YOU REALLY WANT TO DO THIS.
#
#	David Weinberger
#	April 15, 2017
#	david@weinberger.org

# If you want to set the directory interactively, uncomment these lines:
#echo "Please type in the directory you want all the files to be listed"
#read directory

# Otherwise, replace this with the directory you want
directory="shelltest/test/*.txt"
rootdir="shelltest/test"

# Loop through the chosen directory
for entry in  $directory
do
	echo "--------starting file: $entry"
	# does the file have a NotesDate line? Use grep to look for it
	# If it finds it, it will return the number of the line it's on.
	linenumb=$(grep -n "NOTESDATE=" "$entry" | cut -d : -f 1)
    
    # ---- get the file's modification date
	# first get it in Unix format: 200612011159
	dateUnix=$(date -r  "$entry" +%Y%m%d%H%M)
	# now get it in human readable form: 2006-12-01
	dateHuman=$(date -r  "$entry" +%Y-%m-%d)
	
	# create new line of text. Putting the variable into braces
	# apparently helps the OS get the quoting right or something.
	newtext="NOTESDATE=${dateHuman}"
	
	# ---- If it doesn't already have a NOTESDATE line
    if [ -z "$linenumb" ] # If there's no line number from grep
	then
		

		# insert new line
		#http://stackoverflow.com/questions/14846304/sed-command-error-on-macos-x
		# insert the new line, four lines into the file
		# Mac insists on making a backup file. It will have
		# ".ttemp" appended to it
		sed -i.ttemp '4i\'$'\n'${newtext}$'\n' "$entry"
		# restore the file to its original date
		touch -t $dateUnix "$entry"
		# delete the backups
		rm "$entry.ttemp"
	# ---- it already has the line
 	 else
 	 	# Replace the line with a new one with the right date
 		sed -i '' "s/.*NOTESDATE=.*/${newtext}/g" "$entry"
 		touch -t $dateUnix "$entry"
 		# delete the backups
		rm "$entry.ttemp"
 	fi
#  
done
 
# touch -d @$(stat -c "%Y" "$src_file") "$dst_file"