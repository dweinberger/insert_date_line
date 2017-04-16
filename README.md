# insert_date_line
shell script to insert modification date as text while preserving that mod date

	(This works with OSX. The "sed" statement is unique to Mac
	apparently.)

	This script goes through a directory looking for *.txt files.

	It looks in each one for a line that contains "NOTESDATE="

	If it finds one, it adds a human-readable version of
	the last-modified date of that file.

	If it doesn't find that line, it adds it. It will look like this:   
  NOTESDATE=2016-04-30

	It then restores the file to its original last-modified date
	rather than the current date (because it was just re-saved).

	It then deletes the backup automatically created

	I cobbled it together pretty blindly using
	Stackoverflow and other Web sources. I don't know how
	to write shell programs, and I'm sure it shows.

	It's of course open source. Use it any way you like,
	so long as you don't rely on it.

	NOTE: THIS SCRIPT OVERWRITES FILES YOU CARE ABOUT
	SO BACKUP EVERYTHING FIRST, AND THINK ABOUT WHETHER
	YOU REALLY WANT TO DO THIS.

	David Weinberger
	April 15, 2017
	david@weinberger.org
