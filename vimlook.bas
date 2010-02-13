Option Explicit

Private Type STARTUPINFO
   cb As Long
   lpReserved As String
   lpDesktop As String
   lpTitle As String
   dwX As Long
   dwY As Long
   dwXSize As Long
   dwYSize As Long
   dwXCountChars As Long
   dwYCountChars As Long
   dwFillAttribute As Long
   dwFlags As Long
   wShowWindow As Integer
   cbReserved2 As Integer
   lpReserved2 As Long
   hStdInput As Long
   hStdOutput As Long
   hStdError As Long
End Type

Private Type PROCESS_INFORMATION
   hProcess As Long
   hThread As Long
   dwProcessID As Long
   dwThreadID As Long
End Type

Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal _
   hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Declare Function CreateProcessA Lib "kernel32" (ByVal _
   lpApplicationName As Long, ByVal lpCommandLine As String, ByVal _
   lpProcessAttributes As Long, ByVal lpThreadAttributes As Long, _
   ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, _
   ByVal lpEnvironment As Long, ByVal lpCurrentDirectory As Long, _
   lpStartupInfo As STARTUPINFO, lpProcessInformation As _
   PROCESS_INFORMATION) As Long

Private Declare Function CloseHandle Lib "kernel32" (ByVal _
   hObject As Long) As Long

Private Const NORMAL_PRIORITY_CLASS = &H20&
Private Const INFINITE = -1&

Sub VIMReply()
    DoLaunchVIM("Reply")
End Sub

Sub VIMReplyAll()
    DoLaunchVIM("ReplyAll")
End Sub

Sub VIMForward()
    DoLaunchVIM("Forward")
End Sub

Public Sub DoLaunchVIM(MailAction$)

    Const TemporaryFolder = 2
    Const VIMLocation = "C:\Program Files\Vim\vim72\gvim.exe"
    Const VIMLookLocation = "C:\Jeenu\tmp\vimlook\vimlook.vim"

    Dim ol, insp, item, body, fso, tempfile, tfolder, tname, tfile, appRef, x

    Set ol = Application

    Set insp = ol.ActiveInspector
    If insp Is Nothing Then
        Exit Sub
    End If
    Set item = insp.CurrentItem
    If item Is Nothing Then
        Exit Sub
    End If

    body = CStr(item.body)

    Set fso = CreateObject("Scripting.FileSystemObject")
    Set tfolder = fso.GetSpecialFolder(TemporaryFolder)
    tname = fso.GetTempName
    Set tfile = tfolder.CreateTextFile(tname)
    tfile.Write (body)
    tfile.Close

    Dim newItem As Outlook.MailItem

    Select Case MailAction$
        Case "Reply"
            Set newItem = item.Reply
        Case "ReplyAll"
            Set newItem = item.ReplyAll
        Case "Forward"
            Set newItem = item.Forward
    End Select

    item.Close olDiscard

    ExecCmd VIMLocation & " " & Chr(34) & tfolder.Path & "\" & tname & Chr(34) & " " & Chr(34) & "+so " & VIMLookLocation & Chr(34)

    Set tfile = fso.OpenTextFile(tfolder.Path & "\" & tname, 1)
    newItem.body = tfile.ReadAll
    tfile.Close

    fso.DeleteFile (tfolder.Path & "\" & tname)
    newItem.Display

End Sub

Public Sub ExecCmd(cmdline$)

    Dim proc As PROCESS_INFORMATION
    Dim start As STARTUPINFO
    Dim ReturnValue As Integer

    ' Initialize the STARTUPINFO structure:
    start.cb = Len(start)

    ' Start the shelled application:
    ReturnValue = CreateProcessA(0&, cmdline$, 0&, 0&, 1&, _
      NORMAL_PRIORITY_CLASS, 0&, 0&, start, proc)

    ' Wait for the shelled application to finish:
    Do
        ReturnValue = WaitForSingleObject(proc.hProcess, 0)
        DoEvents
    Loop Until ReturnValue <> 258

    ReturnValue = CloseHandle(proc.hProcess)

End Sub

' vim:set ft=vb:
