EvernotePDFClipper
==================

This Mac OS X AppleScript program creates a new note in Evernote containing a **single-page** PDF rendering of the page currently in Safari's front window.  It does this by calling on the third-party application [Paparazzi!](https://derailer.org/paparazzi/).

----
*Author*:      [Michael Hucka](http://www.cds.caltech.edu/~mhucka).

*License*:      This code is licensed under the LGPL version 2.1.  Please see the file [LICENSE.txt](https://raw.github.com/mhucka/EvernotePDFClipper/LICENSE.txt) for details.

*Repository*:   [https://github.com/mhucka/EvernotePDFClipper](https://github.com/mhucka/EvernotePDFClipper)

Requirements
------------

EvernotePDFClipper requires [Paparazzi!](https://derailer.org/paparazzi/) to run.  Please visit the [Paparazzi!](https://derailer.org/paparazzi/) to download it and install it on your computer.


Installation
------------

Copy `EvernotePDFClipper.scpt` to a location of your choice on your computer (perhaps `/Applications`), and rename it `EvernotePDFClipper`.

To make its use convenient, I recommend creating a keyboard shortcut to invoke EvernotePDFClipper.  You can use Mac OS X's built-in facilities for this, or a third-party utility such as [Keyboard Maestro](http://www.keyboardmaestro.com/main/).

<img align="right" width="40%" src="https://raw.githubusercontent.com/mhucka/EvernotePDFClipper/master/.graphics/evernotepdfclipper-screenshot.png">

Usage
-----

Invoke EvernotePDFClipper in some way (e.g., using a keyboard shortcut).  EvernotePDFClipper will then do the following:

1. Query Safari for the page URL and title
2. Copy any text that is highlighted on the page in Safari
3. Query Evernote to get a list of the user's notebooks
4. Create a pop-up dialog and ask you to select a notebook from a list
5. Invoke [Paparazzi!](https://derailer.org/paparazzi/) to render the entire page as a single PDF file
6. Call on Evernote to create a new note with a title equal to the title of the web page, the content equal to any text highlighted on the page in Safari, and with the PDF file as an attachment
7. Send a notification (via OS X's notification center) to let you know it's finished.

Beware that the whole process takes time.  The duration depends on the complexity and content of the page (e.g., whether it loads a lot of JavaScript), the speed of Evernote on your computer, the speed of your network connection, and the speed of your computer.  *EvernotePDFClipper does not queue operations, so make sure to let it finish clipping one web page before invoking it to clip another.*  When it's done, your desktop Evernote application should contain a new note with the PDF attached, as shown in the screen shot at right.

Background and more information
-------------------------------

<img align="right" width="35%" src="https://raw.githubusercontent.com/mhucka/EvernotePDFClipper/master/.graphics/bad-evernote-clipper-screenshot.png"> EvernotePDFClipper was born out of frustrations with Evernote's Web Clipper for Safari.  I dislike the default Evernote clipper's behavior, how it stores information, and how it often produces jumbled output.  (For example of the last, see the screenshot at right.  This is an example of a clipped note with scrambled text in my copy of Evernote version 6.3 on a Mac.)  I realize I may be in the minority, and other people may be perfectly happy with it.  If you're in the latter category, great! Then you don't need this program.  But if you share my frustrations, this small program may help you.

I find the versions of the Evernote Web Clipper after version 5.9.15 to be *incredibly* frustrating for a keyboard-intensive user like me: keyboard focus doesn't move to the clipper interface when the clipper is invoked, pressing the tab key does not move focus between fields, the clipper presents a completely useless "OK" confirmation dialog after you click, etc.  It seems to be designed for people who only use the mouse.   After initially upgrading my copy of the Clipper after a new version came out, I quickly downgraded back to 5.9.15 just to keep my sanity.  At least 5.9.15 solved my user interface complaints, but not my problems with how it stored information.

With the Evernote Web Clipper, I *used to* to be able to save a web page in PDF form.  Years ago, I could use it to clip and store a single-page PDF of a web page, and this was perfect for me.  But at some point this stopped working.  I don't know whether it was due to an update to Mac OS X, or Safari, or Evernote, or a combination.  After it happened, the best I could do was either print to PDF, or use the non-PDF default storage mechanism used by Evernote's Web Clipper.  Neither are ideal: printing to PDF often does not render a page exactly as I see it in my browser, and in addition, it inserts page breaks at arbitrary locations in the output.  Conversely, the default web page storage in Evernote seems to be HTML source, which seems fine &ndash; *until* you try to view it when you don't have a network connection, whereupon you discover that clipped web pages are often unreadable because the page source uses external images, or external fonts, or uses JavaScript that doesn't behave the same when clipped in an Evernote note, or something else happens.  And even when you *do* have a network connection, what you see when you view a clipped page later may not be the same as what you saw at first, because the page may reference external content and Evernote will show you the *current version* of that content when you look at it, rather than what the content was when you clipped the page originally.  In summary, more than half the time, the result is useless to me.

Both the print-to-PDF and the source clipping approaches simply don't work for the purpose of archival storage of a web page: what is stored is not what you see in your browser.  As a researcher, I want to save the most faithful representation of materials that I read and use.

Thus, this program was born.


Reporting problems
------------------

Please use the [issue tracker](https://github.com/mhucka/EvernotePDFClipper/issues) to report problems and other issues with EvernotePDFClipper.  I regret I do not have time to give this program a proper degree of support, so questions and feedback may go unanswered.  However, I will do what I can.


Contributing
------------

I welcome improvements of all kinds, to the code and to the documentation.
Please feel free to contact me or do the following:

1. Fork this repo.  See the links at the top of this GitHub page.
2. Create your feature branch (`git checkout -b my-new-feature`) and write
your changes to the code or documentation.
3. Commit your changes (`git commit -am 'Describe your changes here'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new pull request to notify me of your suggested changes.

EvernotePDFClipper is currently written in AppleScript.  It uses the AppleScript APIs of Safari, Paparazzi! and Evernote to interact with those programs.

The following improvements would be particularly welcome:
* Make EvernotePDFClipper queue up requests, so that the user can issue multiple clipping requests in a row without having to wait for Paparazzi! and Evernote to finish their work for each one.
* Make EvernotePDFClipper ask for tags to add to the note.  This will require querying Evernote for the user's tags, creating a dialog to let the user select one or more tags (or write the tags as text), and attaching the tags to the note in Evernote.


Acknowledgments
---------------

A huge round of thanks to Nate Weaver, the developer of [Paparazzi!](https://derailer.org/paparazzi/), without which this tool would not be possible.  (If you find yourself using EvernotePDFClipper and Paparazzi! frequently, please [give a donation to the author of Paparazzi!](https://derailer.org/paparazzi/donate).)


Copyright and license
---------------------

Copyright (C) 2015-2016 Michael Hucka.

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or any later version.

This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and documentation provided hereunder is on an "as is" basis, and the author has no obligations to provide maintenance, support, updates, enhancements or modifications.  In no event shall the author be liable to any party for direct, indirect, special, incidental or consequential damages, including lost profits, arising out of the use of this software and its documentation, even if the author has been advised of the possibility of such damage.  See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library in the file named "LICENSE.txt" included with the software distribution.
