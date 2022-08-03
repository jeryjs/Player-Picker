;@Ahk2Exe-SetName			Video Picker
;@Ahk2Exe-SetProductName	Video Picker
;@Ahk2Exe-SetDescription	Video Picker - Lets you set upto 5 different Video players`, all selectable by a hotkey [1-5]
;@Ahk2Exe-SetVersion		1.3-alpha
;@Ahk2Exe-SetOrigFilename	Video-Picker.ahk
;@Ahk2Exe-SetCompanyName	Jery

;@Ahk2Exe-SetMainIcon %A_ScriptDir%\Assets\Settings-Icon.ico

#NoEnv
SetTitleMatchMode 2
SetTitleMatchMode Fast
DetectHiddenWindows On
DetectHiddenText On
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
#UseHook
#SIngleInstance Force
#Persistent
; #NoTrayIcon
SetWorkingDir %A_ScriptDir%		;\Working-Directory\Video-Picker
Ini_Read()
Settings_Icon := "Assets\Settings-Icon.ico"

;--------CONFIG-------------------------------------------------
; Player1_Path := "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.exe"
; Player1_Icon := "Z:\DO_NOT_TOUCH\Applications\MPV\installer\mpv.ico"

; Player2_Path := "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.net\mpvnet.exe"
; Player2_Icon := "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.net\mpvnet.exe"

; Player3_Path := "Z:\DO_NOT_TOUCH\Applications\VLC\vlc.exe"
; Player3_Icon := "Z:\DO_NOT_TOUCH\Applications\VLC\vlc.exe"

; Player4_Path := "%A_ProgramFiles%\Windows Media Player\wmplayer.exe"
; Player4_Icon := "%A_ProgramFiles%\Windows Media Player\wmplayer.exe"

; Player5_Path := ""
; Player5_Icon := ""


; Create proper file path in case the path contains spaces
p = %1%
Loop, %0%
   param .= %A_Index% A_Space
File_Path := Trim(param)


;--------MainWindow (GUI 1)-------------------------------------------------
MainWindow:
	Gui, +Owner%scHwnd%
	Gui +HWNDMainWindow +LastFound +AlwaysOnTop +ToolWindow
	Gui, Color, FFFFFF
	WinSet, TransColor, 1 230

	If (Player1_Icon != "")
		Gui, Add, Picture, x0 w-1 h80 gPlayer1, %Player1_Icon%
	If (Player2_Icon != "")
		Gui, Add, Picture, x+30 w-1 h80 gPlayer2, %Player2_Icon%
	If (Player3_Icon != "")
		Gui, Add, Picture, x+30 w-1 h80 gPlayer3, %Player3_Icon%
	If (Player4_Icon != "")
		Gui, Add, Picture, x+30 w-1 h80 gPlayer4, %Player4_Icon%
	If (Player5_Icon != "")
		Gui, Add, Picture, x+30 w-1 h80 gPlayer5, %Player5_Icon%
		
	Gui Add, Picture, x+30 y60 w-1 h30 gSettings, %Settings_Icon%
	; Goto, Settings
	Gui, Show, AutoSize, Pick a Video Player to Play "%File_Path%"
Return

;--------Settings (Gui 2)-------------------------------------------------
Settings:
	Gui, 1: Destroy
	Gui, Settings: +HWNDSettingsWindow +AlwaysOnTop +LastFound
	Gui, Settings: New
	Gui, Font, s11 Ariel
	Gui, Settings: Add, Text, x10, Enter the paths to the *.exe and *.ico files of your desired video players `n (You can also use the same *.exe path for icon instead of *.ico) `n
	
	Gui, Settings: Add, Text, x580 y55, Hotkey:
	Gui, Settings: Add, HotKey, x580 y+1 w75 h20 vREG_Player1_Hotkey, 1
	Gui, Settings: Add, Text, x25 y55, Path to Player 1's .exe-
	Gui, Settings: Add, Edit, vREG_Player1_Path x+5 w370 h20, %Player1_Path%
	Gui, Settings: Add, Text, x25 y+1, Path to Player 1's Icon-
	Gui, Settings: Add, Edit, vREG_Player1_Icon x+5 w370 h20, %Player1_Icon%
	
	Gui, Settings: Add, Text, x580 y120, Hotkey:
	Gui, Settings: Add, HotKey, x580 y+1 w75 h20 vREG_Player2_Hotkey, 2
	Gui, Settings: Add, Text, x25 y120, Path to Player 2's .exe-
	Gui, Settings: Add, Edit, vREG_Player2_Path x+5 w370 h20, %Player2_Path%
	Gui, Settings: Add, Text, x25 y+1, Path to Player 2's Icon-
	Gui, Settings: Add, Edit, vREG_Player2_Icon x+5 w370 h20, %Player2_Icon%
	
	Gui, Settings: Add, Text, x580 y185, Hotkey:
	Gui, Settings: Add, HotKey, x580 y+1 w75 h20 vREG_Player3_Hotkey, 3
	Gui, Settings: Add, Text, x25 y185, Path to Player 3's .exe-
	Gui, Settings: Add, Edit, vREG_Player3_Path x+5 w370 h20, %Player3_Path%
	Gui, Settings: Add, Text, x25 y+1, Path to Player 3's Icon-
	Gui, Settings: Add, Edit, vREG_Player3Icon x+5 w370 h20, %Player3_Icon%
	
	Gui, Settings: Add, Text, x580 y250, Hotkey:
	Gui, Settings: Add, HotKey, x580 y+1 w75 h20 vREG_Player4_Hotkey, 4
	Gui, Settings: Add, Text, x25 y250, Path to Player 4's .exe-
	Gui, Settings: Add, Edit, vREG_Player4_Path x+5 w370 h20, %Player4_Path%
	Gui, Settings: Add, Text, x25 y+1, Path to Player 4's Icon-
	Gui, Settings: Add, Edit, vREG_Player4_Icon x+5 w370 h20, %Player4_Icon%
	
	Gui, Settings: Add, Text, x580 y315, Hotkey:
	Gui, Settings: Add, HotKey, x580 y+1 w75 h20 vREG_Player5_Hotkey, 5
	Gui, Settings: Add, Text, x25 y315, Path to Player 5's .exe-
	Gui, Settings: Add, Edit, vREG_Player5_Path x+5 w370 h20, %Player5_Path%
	Gui, Settings: Add, Text, x25 y+1, Path to Player 5's Icon-
	Gui, Settings: Add, Edit, vREG_Player5_Icon x+5 w370 h20, %Player5_Icon%
	
	Gui, Settings: Add, Text, x25 y380, Background Color:
	Gui, Settings: Add, ComboBox, x+15 y380 w120 vColorChoice Simple, Black|White|Transparent|00FFFF|808080
	Gui, Settings: Add, Text, x+10 y380, (You can also add your own 'Hex' Code for any Color)
	
	Gui, Settings: Add, Button, Default x520 y460 w80 gButton_Cancel, &Cancel
	Gui, Settings: Add, Button, Default x620 y460 w80 gButton_Submit, &Submit

	Gui, Settings: Show, w720 h500, Settings
Return

;SubRoutines for GUI 1 (MainWindow)
Player1:
	Run, "%Player1_Path%" -- "%File_Path%"
	ExitApp
Return
Player2:
	Run, "%Player2_Path%" -- "%File_Path%"
	ExitApp
Return
Player3:
	Run, "%Player3_Path%" -- "%File_Path%"
	ExitApp
Return
Player4:
	Run, "%Player4_Path%" -- "%File_Path%"
	ExitApp
Return
Player5:
	Run, "%Player5_Path%" -- "%File_Path%"
	ExitApp
Return


;SubRoutines for GUI 2 (SETTINGS)
Button_Cancel:
	Gui, Settings: Destroy
	Goto, MainWindow
Return
Button_Submit:
	; MsgBox, You Pressed Submit
	Gui, Settings: Submit
	Ini_Write()
	Gui, Settings: Destroy
	Goto, MainWindow
	; ExitApp
Return



;--------Hotkeys-------------------------------------------------
#If (WinExist("ahk_id " MainWindow) AND !WinExist("ahk_id " HWNDMainWindow))
1::Goto, Player1
2::Goto, Player2
3::Goto, Player3
4::Goto, Player4
5::Goto, Player5
!s::Goto, Settings


#If
Esc::
GuiClose:
GuiEscape:
ExitApp
Return






;--------Ini Settings-------------------------------------------------
Ini_Read() {
	IniRead, Player1_Hotkey, config.ini, Player_1, Player1_Hotkey, 1
	IniRead, Player1_Path, config.ini, Player_1, Player1_Path, A_ProgramFiles\Windows Media Player\wmplayer.exe
	IniRead, Player1_Icon, config.ini, Player_1, Player1_Icon, A_ProgramFiles\Windows Media Player\wmplayer.exe
	MsgBox, %Player1_Hotkey%`n%Player1_Path%`n%Player1_Icon%
	IniRead, Player2_Hotkey, config.ini, Player_2, Player2_Hotkey, 2
	IniRead, Player2_Path, config.ini, Player_2, Player2_Path, Z:\DO_NOT_TOUCH\Applications\MPV\mpv.exe
	IniRead, Player2_Icon, config.ini, Player_2, Player2_Icon, "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.exe"

	IniRead, Player3_Hotkey, config.ini, Player_3, Player3_Hotkey, 3
	IniRead, Player3_Path, config.ini, Player_3, Player3_Path, "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.net\mpvnet.exe"
	IniRead, Player3_Icon, config.ini, Player_3, Player3_Icon, "Z:\DO_NOT_TOUCH\Applications\MPV\mpv.net\mpvnet.exe"

	IniRead, Player4_Hotkey, config.ini, Player_4, Player4_Hotkey, 4
	IniRead, Player4_Path, config.ini, Player_4, Player4_Path, "Z:\DO_NOT_TOUCH\Applications\VLC\vlc.exe"
	IniRead, Player4_Icon, config.ini, Player_4, Player4_Icon, "Z:\DO_NOT_TOUCH\Applications\VLC\vlc.exe"

	IniRead, Player5_Hotkey, config.ini, Player_5, Player5_Hotkey, 5
	IniRead, Player5_Path, config.ini, Player_5, Player5_Path, "A_ProgramFiles\Windows Media Player\wmplayer.exe"
	IniRead, Player5_Icon, config.ini, Player_5, Player5_Icon, "A_ProgramFiles\Windows Media Player\wmplayer.exe"
}

Ini_Write() {
	IniWrite, %REG_Player1_Hotkey%, config.ini, Player_1, Player1_Hotkey
	IniWrite, %REG_Player1_Path%, config.ini, Player_1, Player1_Path
	IniWrite, %REG_Player1_Icon%, config.ini, Player_1, Player1_Icon

	IniWrite, %REG_Player2_Hotkey%, config.ini, Player_2, Player2_Hotkey
	IniWrite, %REG_Player2_Path%, config.ini, Player_2, Player2_Path
	IniWrite, %REG_Player2_Icon%, config.ini, Player_2, Player2_Icon

	IniWrite, %REG_Player3_Hotkey%, config.ini, Player_3, Player3_Hotkey
	IniWrite, %REG_Player3_Path%, config.ini, Player_3, Player3_Path
	IniWrite, %REG_Player3_Icon%, config.ini, Player_3, Player3_Icon

	IniWrite, %REG_Player4_Hotkey%, config.ini, Player_4, Player4_Hotkey
	IniWrite, %REG_Player4_Path%, config.ini, Player_4, Player4_Path
	IniWrite, %REG_Player4_Icon%, config.ini, Player_4, Player4_Icon

	IniWrite, %REG_Player5_Hotkey%, config.ini, Player_5, Player5_Hotkey
	IniWrite, %REG_Player5_Path%, config.ini, Player_5, Player5_Path
	IniWrite, %REG_Player5_Icon%, config.ini, Player_5, Player5_Icon
}