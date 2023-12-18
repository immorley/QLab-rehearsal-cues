tell application id "com.figure53.QLab.5" to tell front workspace
	
	-- get parameters of the original cue	
	set theoriginalcue to first item of (selected as list)
end tell

set theDocument to choose file with prompt "Please select a document to process:"
tell application "Numbers"
	launch
	open theDocument
	delay 2
	set rowcount to row count of table 1 of sheet 1 of front document
	set markercount to rowcount - 1
end tell
set i to 2
set j to 0
repeat markercount times
	tell application "Numbers"
		set markernamecell to "A" & i
		set markertimecell to "B" & i
		set markername to value of cell markernamecell of table 1 of sheet 1 of front document
		set markertime to value of cell markertimecell of table 1 of sheet 1 of front document as string
	end tell
	
	set myArray to my theSplit(markertime, ":")
	set m to item 1 of myArray
	set s to item 2 of myArray
	set markertimeseconds to (m * 60 + s)
	
	tell application id "com.figure53.QLab.5" to tell front workspace
		
		make type "Load"
		set theloadcue to last item of (selected as list)
		set q name of theloadcue to markername
		set q number of theloadcue to ""
		set cue target of theloadcue to theoriginalcue
		set load time of theloadcue to markertimeseconds
		set q color of theloadcue to "orange"
		set continue mode of theloadcue to auto_follow
		
		make type "start"
		set thestartcue to last item of (selected as list)
		set q number of thestartcue to ""
		set cue target of thestartcue to theoriginalcue
		set q color of thestartcue to "green"
		
	end tell
	
	set i to i + 1
	set j to j + 2
end repeat

tell application "Numbers"
	quit
end tell

-- select new cues
set k to j - 1
if k > 1 then
	activate application id "com.figure53.QLab.5"
	delay 0.2
	repeat k times
		tell application "System Events"
			key code 126 using {shift down}
			delay 0.1
		end tell
	end repeat
	
	-- Create QLab Group
	tell application id "com.figure53.QLab.5" to tell front workspace
		make type "group"
		set theselectedgroup to last item of (selected as list)
		set q number of theselectedgroup to ""
		set q name of theselectedgroup to "REHEARSAL CUES"
		set q color of theselectedgroup to "red"
		expand theselectedgroup
	end tell
end if

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit
