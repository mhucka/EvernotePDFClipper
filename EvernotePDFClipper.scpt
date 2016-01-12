set _myName to "EvernotePDFClipper"
set _clipTag to "archived page"
set _defaultNotebook to ".inbox"

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

set _notebookList to {}
tell application "Evernote"
	repeat with _current in every notebook
		copy (the name of _current) to end of _notebookList
	end repeat
end tell

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
end tell

set _titleForFile to do shell script "echo " & quoted form of _pageTitle & " | sed 's|[^a-zA-Z0-9]||g'"
set _pdfTmp to "/Users/mhucka/Desktop/" & _titleForFile & ".pdf"

tell application "Paparazzi!"
	capture _pageURL
	repeat while busy
		-- Wait until the page is loaded.
	end repeat
	save as PDF in _pdfTmp
	close window 1
end tell

tell application "Evernote"
	-- Use Evernote's normal creation command so that it sets the note
	-- properties such as the URL.
	--

	if _noteTitle is equal to "" then
		set _note to create note title _pageTitle from url _pageURL notebook _destNotebook
	else
		set _note to create note title _noteTitle from url _pageURL notebook _destNotebook
	end if

	if tag named _clipTag exists then
		set _tag to tag named _clipTag
	else
		set _tag to make tag with properties {name:_clipTag}
	end if
	assign _tag to _note

	-- Replace the note content completely with the way I want it done.
	--
	set HTML content of item 1 of _note to ""
	if _selectedText is not equal to missing value and _selectedText is not equal to "" then
		tell _note to append text _selectedText
		tell _note to append html "<br><hr><br>"
	end if
	tell _note to append attachment _pdfTmp
end tell

display notification "In notebook '" & _destNotebook & "'" with title _myName subtitle "Captured '" & _pageTitle & "'"


