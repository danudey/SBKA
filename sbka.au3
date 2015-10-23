;
; Steam Bulk Key Activator
; By Shedo Surashu
; http://coffeecone.com/sbka
;
; Version: 1.0.0.12
; Description:
;    SBKA is a command line tool for mass activation of Steam keys.
; License: GPL v3
;

#NoTrayIcon
#Region
#AutoIt3Wrapper_Icon=sbka.ico
#AutoIt3Wrapper_Outfile=bin\sbka.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Steam is owned by VALVe but this utility was made by me (CoffeeCone).
#AutoIt3Wrapper_Res_Description=This is a small utility to help you activate multiple Steam product keys easily.
#AutoIt3Wrapper_Res_Fileversion=1.0.0.13
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=CoffeeCone.com
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#EndRegion

#include <File.au3>
$title = "Steam Bulk Key Activator | Instance ID: " & Random(11111, 99999, 1)

DllCall("Kernel32.dll", "bool", "SetConsoleTitleW", "wstr", $title)

ConsoleWrite(@CRLF)
ConsoleWrite("Steam Bulk Key Activator v" & FileGetVersion(@AutoItExe) & " (sbka.exe)" & @CRLF & "By CoffeeCone <http://coffeecone.com>" & @CRLF & @CRLF)
If $CmdLine[0] < 1 Then
	WinSetOnTop($title, "", 1)
	ConsoleWrite("Description:" & @CRLF)
	ConsoleWrite("   If you have a list of Steam keys and want to check each" & @CRLF)
	ConsoleWrite("   and every one of them, you may get a little bored while" & @CRLF)
	ConsoleWrite("   doing it. Thus, I made this." & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("Usage:" & @CRLF)
	ConsoleWrite("   Make sure Steam is already running. In systems with" & @CRLF)
	ConsoleWrite("   multiple monitors, make sure Steam is on the MAIN one." & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("   Typical usage is:" & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("      sbka mylist.txt" & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("   TIP: You can add -r at the end to make it check random" & @CRLF)
	ConsoleWrite("        numbers. Note that this has a chance of checking" & @CRLF)
	ConsoleWrite("        the same key multiple times as it is randomized." & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("      sbka mylist.txt -r" & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("   TIP: You can also activate a single key by adding a -k" & @CRLF)
	ConsoleWrite("        after stating the key name. Note that this doesn't" & @CRLF)
	ConsoleWrite("        work with the -r flag." & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("      sbka PZ38Z-M429V-7LX79 -k" & @CRLF)
	ConsoleWrite(@CRLF)
	ConsoleWrite("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" & @CRLF)
	$passed = False
	If WinExists("[TITLE:Settings; REGEXPCLASS:USurface\_\d*]") Then
		WinClose("[TITLE:Settings; REGEXPCLASS:USurface\_\d*]")
	EndIf
	If WinExists("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]") Then
		WinClose("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]")
	EndIf
	If (WinExists("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]")) Then
		WinActivate("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]")
		If WinActive("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]") Then
			$passed = True
		EndIf
	EndIf
	If ($passed = True) Then
		ConsoleWrite("   Status: Positive (Everything seems to be OK.)" & @CRLF)
	Else
		ConsoleWrite("   Status: Negative (Please see the usage info.)" & @CRLF)
	EndIf
	ConsoleWrite("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" & @CRLF)
	WinSetOnTop($title, "", 0)
	WinActivate($title)
ElseIf $CmdLine[0] > 1 And $CmdLine[2] = "-k" Then
	WinMove($title, "", 500, 10)
	WinSetOnTop($title, "", 1)

	ConsoleWrite(" -> Processing single key: " & $CmdLine[1] & " ")
	steamActivate($CmdLine[1])

	WinSetOnTop($title, "", 0)
	WinActivate($title)
ElseIf FileExists($CmdLine[1]) Then
	WinMove($title, "", 500, 10)
	WinSetOnTop($title, "", 1)

	FileOpen($CmdLine[1], 0)
	$total = _FileCountLines($CmdLine[1])

	For $i = 1 To $total
		If $CmdLine[0] > 1 And $CmdLine[2] = "-r" Then
			$key = FileReadLine($CmdLine[1], Random(1, $total, 1))
			ConsoleWrite(" -> Processing random key " & $i & " out of " & $total & ": " & $key & " ")
		Else
			$key = FileReadLine($CmdLine[1], $i)
			ConsoleWrite(" -> Processing key " & $i & " out of " & $total & ": " & $key & " ")
		EndIf
		steamActivate($key)
	Next
	FileClose($CmdLine[1])

	WinSetOnTop($title, "", 0)
	WinActivate($title)
Else
	ConsoleWrite(" ERROR: No file found. Please run 'sbka' only to for help." & @CRLF)
	WinActivate($title)
EndIf

Func steamActivate($key)
	If WinExists("[TITLE:Settings; REGEXPCLASS:USurface\_\d*]") Then
		WinClose("[TITLE:Settings; REGEXPCLASS:USurface\_\d*]")
	EndIf
	If WinExists("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]") Then
		WinClose("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]")
	EndIf
	If (WinExists("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]")) Then
		WinActivate("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]")
		If WinActive("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]") Then
			WinSetState("[TITLE:Steam; REGEXPCLASS:USurface\_\d*]", "", @SW_MAXIMIZE)
			MouseClick("left", 160, 15, 1, 1)
			Sleep(250)
			MouseClick("left", 160, 65, 1, 1)
			WinWait("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]", "", 3)
			If Not WinExists("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]") Then
				ConsoleWrite(" - ERROR!")
			Else
				WinMove("[TITLE:Product Activation; REGEXPCLASS:USurface\_\d*]", "", 0, 0)
				MouseClick("left", 310, 565, 1, 1)
				ConsoleWrite(".")
				Sleep(250)
				MouseClick("left", 310, 565, 1, 1)
				ConsoleWrite(".")
				Sleep(250)
				MouseClick("left", 100, 190, 1, 1)
				ConsoleWrite(".")
				Sleep(250)
				Send($key)
				ConsoleWrite(".")
				Sleep(250)
				MouseClick("left", 310, 565, 1, 1)
				ConsoleWrite(".")
				WinWait("[TITLE:Steam - Working; REGEXPCLASS:USurface\_\d*]", "", 3)
				If WinExists("[TITLE:Steam - Working; REGEXPCLASS:USurface\_\d*]") Then
					WinWaitClose("[TITLE:Steam - Working; REGEXPCLASS:USurface\_\d*]")
				EndIf
				Sleep(250)
				MouseClick("left", 310, 565, 1, 1)
				ConsoleWrite(".")
				Sleep(500)
				MouseClick("left", 310, 565, 1, 1)
				ConsoleWrite(".")
				Sleep(500)
				MouseClick("left", 460, 13, 1, 1)
				ConsoleWrite("DONE!" & @CRLF)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>steamActivate
