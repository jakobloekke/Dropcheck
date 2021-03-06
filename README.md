Dropcheck
=========

Dropcheck is a **web app** that runs out of your **Dropbox**.
It turns a simple .txt file into a mobile checklist.

![screenshot](http://www.jakobloekkemadsen.com/articles/dropcheck-a-magic-checklist-using-dropbox-and-knockout-js/dropcheck1.png)

How to install
--------------
1. [Download](https://github.com/jakobloekke/Dropcheck/zipball/master/ "Download Dropcheck") and put the "Dropcheck" folder in your Dropbox public folder.
3. Access the public link of "dropcheck.html" through mobile Safari.
4. Bookmark the page to your iPhone homescreen.

Known issues
------------
Windows users need to manually save the .txt file with UTF-8 encoding in Notepad. 
Otherwise international characters will look funny ...

Demo link
---------
http://dl.dropbox.com/u/2886688/web/Dropcheck/Dropcheck/dropcheck.html


TODOs / Ideas
-------------

* Add indication that data is coming from localstorage - probably this should be presented near the "reset to Dropbox link"
* Fix handling of international characters
* Add handling of multiple lists

Tech
----

Knockout.js - CoffeeScript - SCSS - Jade
