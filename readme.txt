About
=====

Vimlook is a VBA script M$ Outlook for launching VIM as its email editor. This
script, as of now, can launch VIM for creating, editing, replying(-all) and
forwading mails within Outlook.

Setup
=====

 0.  Install GVIM
 1.  Before trying to setup Vimlook, you must enable macros in M$ Outlook. Go
     to Tools -> Macro -> Security and select "No security checks for Macros",
     and restart Outlook. You must be cautious in executing any other macros
     since the security checks are disabled.
 2.  Place vimlook.bas and vimlook.vim in a directory.
 3.  Right-click on My Computer Icon, then go to properties, then to Advanced
     tab and then click Environment Variables. Create two user variables
     VIMLOOK_VIM and VIMLOOK_LOC and assign them appropriate vales. For
     example:
     Set VIMLOOK_VIM to C:\Program Files\Vim\vim73\gvim.exe
     Set VIMLOOK_LOC to C:\Jeenu\vimlook (no trailing back slash)
 4.  Open Outlook.
 5.  Press Alt+F11 to launch Visual Basic editor.
 6.  File -> Import. Locate and import vimlook.bas.
 7.  Close Visual Basic editor and go to Outlook main window.
 8.  View -> Toolbars -> Customize; and select the Commands tab.
 9.  Select Macros from the list on the left hand side. You should now see
     VIMForward, VIMReply and VIMReplyAll on the right hand side.
 10. Drag each of to a convenient location on the toolbar.
 11. Right-click on the newly-created toolbar button (witout closing the
     Customize dialog), and you can rename the label for your button. Also you
     can insert '&' character to create a keyboard shortcut. For example,
     renaming the VIMReply button as VIM&Reply will let you access the button
     with Alt+R short cut (Make sure your short cut doesn't conflict with that
     of Outlook's deafault ones).
 12. To change the icon on newly created the toolbar buttons, Right Click ->
     Copy Button Image on another button of your choice, then come back Right
     Click -> Paste Button Image on the newly inserted button

 Note:
 - In addition, you  can open a mail item in its own window, right-click on
   the ribbon -> Customize Quick Access Toolbar... You can add buttons to this
   window in similar way mentioned above to quickly access macros from this
   window.
 - The file vimlook.vim is sourced before launching VIM. So you can customize
   your VIM settings there.

Usage
=====

The VBA script has 5 entry points:

 - VIMReply, VIMReplyAll, VIMForward are for replying, replying all and
   forwarding mails that are already in Outlook. Select a mail item and invoke
   the macro (either directly or via. the buttons added to toolbar as
   described above). Finish your editing, do :wq, and you'll back in Outlook
   with your edited mail opened ready to send
 - VIMEdit is for editing a mail item that you've saved as Draft. Do not use it
   for composing, replying or forwarding
 - VIMNew is for composing a new mail with Vim

The following features are offered

 - Select relevant portion of mail and press > to quote and format. This can
   optionally prefix with a count in which case the selected text will be
   indented proportionately
 - Select text and use \q to quote it without formatting
 - Text exceeding the 72-column width are highligted in red. Use \f on a
   paragraph to re-format it to 72-column width. If you happen to adjust text
   width, use the command SetupMatch to re-highligt using the new text width

TODO
====

 - Once you've launched VIM, Outlook waits for you to close VIM window.
   Outlook experinece isn't that great until you close VIM, sadly. Possible
   solutions:

    * Spawn a thread? Not sure if that's supported in VBA
    * Write and external VB/VB.Net script

 - Make the formatting more intelligent and civilized. Possibly write a VIM
   function and assign to 'formatexpr'. It should take care of formatting
   lines that are less than 'tw' length (which is currently messed by the
   normal gq). Also it should leave the already-quoted part of reply alone
