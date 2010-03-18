About
=====

Vimlook is a VBA script M$ Outlook for launching VIM as its email editor. This
script, as of now, can launch VIM for creating, editing, replying(-all) and
forwading mails within Outlook.

Howto use:
==========

 0.  Place vimlook.bas and vimlook.vim in a directory.
 1.  Make sure the paths in DoLaunchVIM subroutine in vimlook.bas file are
     valid
 2.  Open Outlook.
 3.  Press Alt+F11 to launch Visual Basic editor.
 4.  File -> Import. Locate and import vimlook.bas.
 5.  Close Visual Basic editor and go to Outlook main window.
 6.  View -> Toolbars -> Customize; and select the Commands tab.
 7.  Select Macros from the list on the left hand side. You should now see
     VIMForward, VIMReply and VIMReplyAll on the right hand side.
 8.  Drag each of to a convenient location on the toolbar.
 9.  Right-click on the newly-created toolbar button (witout closing the
     Customize dialog), and you can rename the label for your button. Also you
     can insert '&' character to create a keyboard shortcut. For example,
     renaming the VIMReply button as VIM&Reply will let you access the button
     with Alt+R short cut (Make sure your short cut doesn't conflict with that
     of Outlook's deafault ones).
 10. In addition, you  can open a mail item in its own window, right-click on
     the ribbon > Customize Quick Access Toolbar... You can add buttons to
     this window in similar way mentioned above to quickly access macros from
     this window.
 11. Select a mail and click on the button on toolbar. It should now launch
     VIM with mail formatted accordingly. Save and quit (:wq) and you'll get
     the composed mail opened in Outlook ready to be sent.
 12. The file vimlook.vim is sourced before launching VIM. So you can
     customize your VIM settings there.

TODO:
=====

 * Once you've launched VIM, Outlook waits for you to close VIM window.
   Outlook experinece isn't that great until you close VIM, sadly. Possible
   solutions:

    * Spawn a thread? Not sure if that's supported in VBA
    * Write and external VB/VB.Net script

 * Make the formatting more intelligent and civilized. Possibly write a VIM
   function and assign to 'formatexpr'. It should take care of formatting
   lines that are less than 'tw' length (which is currently messed by the
   normal gq). Also it should leave the already-quoted part of reply alone
