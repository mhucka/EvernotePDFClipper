-- =============================================================================
-- @file    EvernotePDFClipper
-- @brief   Create single-page PDF of page currently in Safari's front window. Also saves webarchive.
-- @author  Michael Hucka <mhucka@caltech.edu>
-- @license Please see the file LICENSE.html in the parent directory
-- =============================================================================

-- Test if Paparazzi! is installed and complain if it isn't.

try
	tell application "Finder"
		get name of application file id "org.derailer.Paparazzi"
	end tell
on error
	display dialog "Could not find application Paparazzi! – quitting."
	return 1
end try

-- Good so far.  Proceed.

set _myName to "EvernotePDFClipper"
set _clipTag to "archived page"
set _defaultNotebook to ".inbox"
tell application "Finder"
	set _home to home as string
	set _desktop to _home & "Desktop"
end tell

-- Get info from Safari.

tell application "Safari" to tell document 1
	set _pageTitle to name
	set _pageURL to URL
	set _selectedText to (do JavaScript "(''+getSelection())")
	if _selectedText is equal to missing value then
		set _html to source
	end if
end tell

try
	get _pageURL
on error
	display dialog "Cannot obtain web page URL." buttons {"OK"} with icon 2
	return 1
end try

-- Get notebook list from Evernote.

set _notebookList to {}
tell application "Evernote"
	repeat with _current in every notebook
		copy (the name of _current) to end of _notebookList
	end repeat
end tell

-- Ask user which notebook they want to use and for an optional
-- title for the note to be created.

tell application "Safari"
	activate

	-- The next code is a simple sort routine from
	-- http://www.macosxautomation.com/applescript/sbrt/sbrt-05.html
	-- I cannot find an author name or licensing terms.  The page source
	-- has an HTML author metadata field value of "Nyhthawk Productions".

	-- I had to inline the code here instead of definining a function elsewhere
	-- in this file because when I invoked the function from inside a "tell" block,
	-- AppleScript would give some weird error.  I gave up on understanding why
	-- and just inlined in here.

	set the index_list to {}
	set the sorted_list to {}
	repeat (the number of items in _notebookList) times
		set the low_item to ""
		repeat with i from 1 to (number of items in _notebookList)
			if i is not in the index_list then
				set this_item to item i of _notebookList as text
				if the low_item is "" then
					set the low_item to this_item
					set the low_item_index to i
				else if this_item comes before the low_item then
					set the low_item to this_item
					set the low_item_index to i
				end if
			end if
		end repeat
		set the end of sorted_list to the low_item
		set the end of the index_list to the low_item_index
	end repeat
	set _list to sorted_list

	-- Now finally put up a dialog asking which notebook to use.
	-- If the user clicks Cancel, quit now.

	set _destNotebook to choose from list _list with title _myName with prompt "Select notebook:" default items _defaultNotebook
	if _destNotebook is false then
		return 1
	end if

	set _noteTitle to the text returned of (display dialog "Title for note (leave empty to use web page title):" default answer "")
	if _noteTitle is equal to "" then
		set _noteTitle to _pageTitle
	end if
end tell

set _titleForFile to do shell script "echo " & quoted form of _pageTitle & " | sed 's|[^a-zA-Z0-9]||g'"
set _pdfTmp to _desktop & ":" & _titleForFile & ".pdf"
set _archiveTmp to _desktop & ":" & _titleForFile & ".webarchive"

-- Save single-page PDF.

tell application "Paparazzi!"
	capture _pageURL
	repeat while busy
		-- Wait until the page is loaded.
	end repeat
	save as PDF in _pdfTmp
	close window 1
end tell

-- Save web archive of page.

try
	do shell script "/opt/local/bin/webarchiver -url '" & _pageURL & "' -output " & POSIX path of _archiveTmp
on error
	set _archiveTmp to missing value
end try

-- Call on Evernote to create the note, then attach the PDf and archive to it.

tell application "Evernote"
	-- Use Evernote's normal creation command so that it sets the note
	-- properties such as the URL.

	set _note to create note title _noteTitle from url _pageURL notebook _destNotebook
	set source URL of _note to _pageURL

	if tag named _clipTag exists then
		set _tag to tag named _clipTag
	else
		set _tag to make tag with properties {name:_clipTag}
	end if
	assign _tag to _note

	-- Replace the note content completely with the way I want it done.

	if _selectedText is not equal to missing value and _selectedText is not equal to "" then
		set HTML content of item 1 of _note to "Excerpt:<br><blockquote><em>" & _selectedText & "</em></blockquote><hr><br>"
	else
		set HTML content of item 1 of _note to ""
	end if

	-- Finally, attach the PDF and the archive.

	tell _note to append attachment _pdfTmp
	if _archiveTmp is not equal to missing value then
		tell _note to append attachment _archiveTmp
	end if
end tell

-- Clean up.
tell application "Finder" to delete _pdfTmp

display notification "In notebook '" & _destNotebook & "'" with title _myName subtitle "Captured '" & _pageTitle & "'"

