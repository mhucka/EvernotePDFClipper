EvernotePDFClipper
==================

This Mac OS X program creates a new note in Evernote containing a **single-page** PDF rendering of the page currently in Safari's front window.  It does this by using the application [Paparazzi!](https://derailer.org/paparazzi/).

----
*Author*:      [Michael Hucka](http://www.cds.caltech.edu/~mhucka).

*License*:      This code is licensed under the LGPL version 2.1.  Please see the file [LICENSE.txt](https://raw.github.com/mhucka/EvernotePDFClipper/LICENSE.txt) for details.

*Repository*:   [https://github.com/mhucka/EvernotePDFClipper](https://github.com/mhucka/EvernotePDFClipper)

Requirements and strong recommendations
---------------------------------------

EvernotePDFClipper requires [Paparazzi!](https://derailer.org/paparazzi/) to run.  Please visit the [Paparazzi!](https://derailer.org/paparazzi/) to install it.

To make its use convenient, I recommend creating a keyboard shortcut for EvernotePDFClipper.  You can use Mac OS X's built-in facilities for this, or a third-party utility such as [Keyboard Maestro](http://www.keyboardmaestro.com/main/).

Usage
-----

Invoke `EvernotePDFClipper` in some way (e.g., using a keyboard shortcut).  `EvernotePDFClipper` will then do the following:

# Query Safari for the page URL and title
# Copy any text that is highlighted on the page in Safari
# Query Evernote to get a list of the user's notebooks
# Ask the user to select a notebook from a list in a pop-up window
# Invoke [Paparazzi!](https://derailer.org/paparazzi/) to render the entire page as a single PDF file
# Call on Evernote to create a new note with a title equal to the title of the web page, the content equal to any text highlighted on the page in Safari, and with the PDF file as an attachment
# Send a notification (via OS X's notification center) to let you know it's finished.


Background and more information
-------------------------------

EvernotePDFClipper was born out of frustrations with Evernote's Web Clipper for Safari.  I neither like the default Evernote clipper's behavior nor how it stores information.  I realize I may be in the minority, and other people may be perfectly happy with it.  If you're in the latter category, great! Then you don't need this program.  But if you share my frustrations, this small program may help you.

I find the versions after version 5.9.15 of the Evernote web clipper to be *incredibly* frustrating for a keyboard-intensive user like me: keyboard focus doesn't move to the clipper interface when the clipper is invoked, pressing the tab key does not move focus between fields, the clipper presents a completely useless "OK" confirmation dialog after you click, etc.  Quickly after upgrading from 5.9.15, I downgraded back to 5.9.15 just to keep my sanity.  It solved my user interface complaints, but not my problem with information storage.

At some point even before 5.9.15, I lost the ability to save web pages as faithful renditions in PDF form.  The Evernote Web Clipper *used to* provide to this capability: years ago, I could use it to clip a whole-page PDF of a web page, and this was perfect for me.  But at some point it stopped working.  I don't know whether it was due to an update to Mac OS X, or Safari, or Evernote, or a combination.  The best I could do was either print-to-PDF, or use the non-PDF default storage mechanism used by Evernote's Web Clipper.  Neither are ideal: printing to PDF often does not render a page exactly as I see it in my browser, and in addition, it inserts page breaks at arbitrary locations in the output.  Conversely, the default web page storage in Evernote seems to be HTML source, which seems fine &ndash; until you try to view it when you don't have a network connection, whereupon you discover that clipped web pages are often unreadable because the page source uses external images, or external fonts, or uses JavaScript that doesn't behave the same when clipped in an Evernote note, or something else happens.  And even when you *do* have a network connection, what you see when you view a clipped page later may not be the same as what you saw at first, because the page may reference external content and Evernote will show you the *current version* of that content rather than what it was when you clipped the page in the first place.  In summary, more than half the time, the result is useless to me after the fact.

Both the print-to-PDF and the source clipping approaches simply don't work for the purpose of archival storage of a web page: what is stored is not what you see in your browser.  As a researcher, I want to save as faithful of a representation of what I originally saw as I can have.

Thus, this program was born.


Reporting problems
------------------

Please use the [issue tracker](https://github.com/mhucka/EvernotePDFClipper/issues) to report problems and other issues with `EvernotePDFClipper`.  I regret I do not have time to give this program a proper degree of support, so questions and feedback may go unanswered.  However, I will do what I can.


Contributing
------------

I welcome improvements of all kinds, to the code and to the documentation.
Please feel free to contact me or do the following:

1. Fork this repo.  See the links at the top of the github page.
2. Create your feature branch (`git checkout -b my-new-feature`) and write
your changes to the code or documentation.
3. Commit your changes (`git commit -am 'Describe your changes here'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new pull request to notify me of your suggested changes.

EvernotePDFClipper is currently written in AppleScript.  It uses the AppleScript APIs of Safari, Paparazzi! and Evernote to interact with those programs.


Copyright and license
---------------------

Copyright (C) 2015 Michael Hucka.

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or any later version.

This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and documentation provided hereunder is on an "as is" basis, and the author has no obligations to provide maintenance, support, updates, enhancements or modifications.  In no event shall the author be liable to any party for direct, indirect, special, incidental or consequential damages, including lost profits, arising out of the use of this software and its documentation, even if the author has been advised of the possibility of such damage.  See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library in the file named "COPYING.txt" included with the software distribution.
