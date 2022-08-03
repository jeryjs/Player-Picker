;@Ahk2Exe-SetName		Video Picker
;@Ahk2Exe-SetProductName	Video Picker
;@Ahk2Exe-SetDescription	Video Picker - Lets you set upto 5 different Video players`, all selectable by a hotkey [1-5]
;@Ahk2Exe-SetVersion		0.2-alpha
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

Global Player1_Hotkey, Global Player2_Hotkey, Global Player3_Hotkey, Global Player4_Hotkey, Global Player5_Hotkey
Global Player1_Path, Global Player2_Path, Global Player3_Path, Global Player4_Path, Global Player5_Path
Global Player1_Icon, Global Player2_Icon, Global Player3_Icon, Global Player4_Icon, Global Player5_Icon

Global REG_Player1_Hotkey, Global REG_Player2_Hotkey, Global REG_Player3_Hotkey, Global REG_Player4_Hotkey, Global REG_Player5_Hotkey
Global REG_Player1_Path, Global REG_Player2_Path, Global REG_Player3_Path, Global REG_Player4_Path, Global REG_Player5_Path
Global REG_Player1_Icon, Global REG_Player2_Icon, Global REG_Player3_Icon, Global REG_Player4_Icon, Global REG_Player5_Icon

Global ColorChoice, Global REG_ColorChoice

Ini_Read()

; Create proper file path in case the path contains spaces
p = %1%
Loop, %0%
   param .= %A_Index% A_Space
File_Path := Trim(param)

Settings_Icon := "Assets\Settings-Icon.ico"

;--------Hotkeys-------------------------------------------------
#If (WinExist("Pick a Video Player to Play") AND !WinExist("Settings"))
Hotkey, IfWinNotExist, Settings
Hotkey, %Player1_Hotkey%, Player1
Hotkey, %Player2_Hotkey%, Player2
Hotkey, %Player3_Hotkey%, Player3
Hotkey, %Player4_Hotkey%, Player4
Hotkey, %Player5_Hotkey%, Player5
#If


;--------MainWindow (GUI 1)-------------------------------------------------
MainWindow:
Ini_Read()
; MsgBox, "%Player1_Hotkey%"`n"%Player1_Path%"`n"%Player1_Icon%"`n`n"%Player2_Hotkey%"`n"%Player2_Path%"`n"%Player2_Icon%"`n`n"%Player3_Hotkey%"`n"%Player3_Path%"`n"%Player3_Icon%"`n`n"%Player4_Hotkey%"`n"%Player4_Path%"`n"%Player4_Icon%"`n`n"%Player5_Hotkey%"`n"%Player5_Path%"`n"%Player5_Icon%"`n`n"%ColorChoice%"
	Gui, +Owner%scHwnd%
	Gui +HWNDMainWindow +LastFound +AlwaysOnTop +ToolWindow
	If (ColorChoice = "ERROR")
		ColorChoice := "Black"
	If (ColorChoice = "Transparent")
		ColorChoice := 1
	Gui, Color, %ColorChoice%
	WinSet, TransColor, 1 240

	If (Player1_Icon != "ERROR")
		Gui, Add, Picture, x0 w-1 h80 gPlayer1, %Player1_Icon%
	If (Player2_Icon != "ERROR")
		Gui, Add, Picture, x+30 wp hp gPlayer2, %Player2_Icon%
	If (Player3_Icon != "ERROR")
		Gui, Add, Picture, x+30 w-1 hp gPlayer3, %Player3_Icon%
	If (Player4_Icon != "ERROR")
		Gui, Add, Picture, x+30 w-1 hp gPlayer4, %Player4_Icon%
	If (Player5_Icon != "ERROR")
		Gui, Add, Picture, x+30 w-1 hp gPlayer5, %Player5_Icon%
		
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
	
	Gui, Settings: Add, Text, x580 y55 section, Hotkey:
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
	Gui, Settings: Add, ComboBox, x+15 y380 w120 vREG_ColorChoice Simple, Black|White|Transparent|00FFFF|808080
	Gui, Settings: Add, Text, x+10 y380, (You can also add your own 'Hex' Code for any Color)
	
	Gui, Settings: Add, Button, Default x520 y460 w80, &Cancel
	Gui, Settings: Add, Button, Default x620 y460 w80, &Submit

	Gui, Settings: Show, w720 h500, Settings
Return

;SubRoutines for GUI 1 (MainWindow)
Player1:
	Gui, Hide
	if RegExMatch(Player1_Path, ".exe")
		Run, "%Player1_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Video Picker, Add the path to the video player in settings first!
	ExitApp
Return
Player2:
	Gui, Hide
	If RegExMatch(Player2_Path, ".exe")
		Run, "%Player2_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Video Picker, Add the path to the video player in settings first!
	ExitApp
Return
Player3:
	Gui, Hide
	If RegExMatch(Player3_Path, ".exe")
		Run, "%Player3_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Video Picker, Add the path to the video player in settings first!
	ExitApp
Return
Player4:
	Gui, Hide
	If RegExMatch(Player4_Path, ".exe")
		Run, "%Player4_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Video Picker, Add the path to the video player in settings first!
	ExitApp
Return
Player5:
	Gui, Hide
	If RegExMatch(Player5_Path, ".exe")
		Run, "%Player5_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Video Picker, Add the path to the video player in settings first!
	ExitApp
Return


;SubRoutines for GUI 2 (SETTINGS)
SettingsButtonCancel:
	Gui, Settings: Cancel
	Gui, Settings: Destroy
	Goto, MainWindow
Return
SettingsButtonSubmit:
	; MsgBox, You Pressed Submit
	Gui, Settings: Submit
	MsgBox, "%REG_Player1_Hotkey%"`n"%REG_Player1_Path%"`n"%REG_Player1_Icon%"`n`n"%REG_Player2_Hotkey%"`n"%REG_Player2_Path%"`n"%REG_Player2_Icon%"`n`n"%REG_Player3_Hotkey%"`n"%REG_Player3_Path%"`n"%REG_Player3_Icon%"`n`n"%REG_Player4_Hotkey%"`n"%REG_Player4_Path%"`n"%REG_Player4_Icon%"`n`n"%REG_Player5_Hotkey%"`n"%REG_Player5_Path%"`n"%REG_Player5_Icon%"`n`n"%ColorChoice%"
	Ini_Write()	
	Gui, Settings: Destroy
	Goto, MainWindow
	; ExitApp
Return



;--------Hotkeys-------------------------------------------------
; #If (WinExist("ahk_id " MainWindow) AND !WinExist("ahk_id " HWNDMainWindow))
; 1::Goto, Player1
; 2::Goto, Player2
; 3::Goto, Player3
; 4::Goto, Player4
; 5::Goto, Player5
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
	IniRead, Player1_Path, config.ini, Player_1, Player1_Path, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
	IniRead, Player1_Icon, config.ini, Player_1, Player1_Icon, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
	
	IniRead, Player2_Hotkey, config.ini, Player_2, Player2_Hotkey, 2
	IniRead, Player2_Path, config.ini, Player_2, Player2_Path
	IniRead, Player2_Icon, config.ini, Player_2, Player2_Icon

	IniRead, Player3_Hotkey, config.ini, Player_3, Player3_Hotkey, 3
	IniRead, Player3_Path, config.ini, Player_3, Player3_Path
	IniRead, Player3_Icon, config.ini, Player_3, Player3_Icon

	IniRead, Player4_Hotkey, config.ini, Player_4, Player4_Hotkey, 4
	IniRead, Player4_Path, config.ini, Player_4, Player4_Path
	IniRead, Player4_Icon, config.ini, Player_4, Player4_Icon

	IniRead, Player5_Hotkey, config.ini, Player_5, Player5_Hotkey, 5
	IniRead, Player5_Path, config.ini, Player_5, Player5_Path
	IniRead, Player5_Icon, config.ini, Player_5, Player5_Icon
	
	IniRead, ColorChoice, config.ini, GUI, ColorChoice
}

Ini_Write() {
	IniDelete, config.ini, Player_1
	IniWrite, %REG_Player1_Hotkey%, config.ini, Player_1, Player1_Hotkey
	IniWrite, %REG_Player1_Path%, config.ini, Player_1, Player1_Path
	IniWrite, %REG_Player1_Icon%, config.ini, Player_1, Player1_Icon

	IniDelete, config.ini, Player_2
	IniWrite, %REG_Player2_Hotkey%, config.ini, Player_2, Player2_Hotkey
	IniWrite, %REG_Player2_Path%, config.ini, Player_2, Player2_Path
	IniWrite, %REG_Player2_Icon%, config.ini, Player_2, Player2_Icon

	IniDelete, config.ini, Player_3
	IniWrite, %REG_Player3_Hotkey%, config.ini, Player_3, Player3_Hotkey
	IniWrite, %REG_Player3_Path%, config.ini, Player_3, Player3_Path
	IniWrite, %REG_Player3_Icon%, config.ini, Player_3, Player3_Icon

	IniDelete, config.ini, Player_4
	IniWrite, %REG_Player4_Hotkey%, config.ini, Player_4, Player4_Hotkey
	IniWrite, %REG_Player4_Path%, config.ini, Player_4, Player4_Path
	IniWrite, %REG_Player4_Icon%, config.ini, Player_4, Player4_Icon

	IniDelete, config.ini, Player_5
	IniWrite, %REG_Player5_Hotkey%, config.ini, Player_5, Player5_Hotkey
	IniWrite, %REG_Player5_Path%, config.ini, Player_5, Player5_Path
	IniWrite, %REG_Player5_Icon%, config.ini, Player_5, Player5_Icon
	
	IniWrite, %REG_ColorChoice%, config.ini, GUI, ColorChoice
}

; Fix Hotkeys
; Fix_Hotkeys() {
; If (Player1_Hotkey = "")
	; Player1_Hotkey := 1
; If (Player2_Hotkey = "")
	; Player2_Hotkey := 2
; If (Player3_Hotkey = "")
	; Player3_Hotkey := 3
; If (Player4_Hotkey = "")
	; Player4_Hotkey := 4
; If (Player5_Hotkey = "")
	; Player5_Hotkey := 5
; }