tell application id "com.figure53.QLab.5" to tell front workspace
	
	-- get parameters of the original cue	
	set theoriginalcue to first item of (selected as list)
	set slicelist to slice markers of theoriginalcue
	set numberofslices to count of slicelist
	set i to 1
	set j to 0
	
	repeat numberofslices times
		set individualslice to item i of slicelist
		set individualslicetime to time of individualslice
		
		make type "Load"
		set theloadcue to last item of (selected as list)
		set q number of theloadcue to ""
		set cue target of theloadcue to theoriginalcue
		set load time of theloadcue to individualslicetime
		set q color of theloadcue to "orange"
		set continue mode of theloadcue to auto_follow
		
		make type "start"
		set thestartcue to last item of (selected as list)
		set q number of thestartcue to ""
		set cue target of thestartcue to theoriginalcue
		set q color of thestartcue to "green"
		
		set i to i + 1
		set j to j + 2
	end repeat
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
