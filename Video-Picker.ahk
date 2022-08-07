;@Ahk2Exe-SetName		Video Picker
;@Ahk2Exe-ExeName	Video Picker
;@Ahk2Exe-SetProductName	Video Picker
;@Ahk2Exe-SetDescription	Video Picker
;@Ahk2Exe-SetVersion		0.3.7-alpha
CurrentVersion := 			"0.3.7-alpha"
;@Ahk2Exe-SetOrigFilename	Video-Picker.ahk
;@Ahk2Exe-SetCompanyName	Jery

;@Ahk2Exe-SetMainIcon Assets\VideoPicker_Main.ico

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
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

Settings_Icon := % A_Temp "\VideoPicker_Settings-Icon.ico"
Main_Icon := % A_Temp "\VideoPicker_Main.ico"

FileInstall, Assets\VideoPicker_Main.ico, %Main_Icon%
FileInstall, Assets\VideoPicker_Settings-Icon.ico, %Settings_Icon%

Menu, tray, icon, %Main_Icon%

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


;--------Hotkeys-------------------------------------------------
; #If (WinExist("Pick a Video Player to Play") AND !WinExist("Settings"))
Hotkey, IfWinNotActive, Settings
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
	Gui, Color, % RegExReplace(ColorChoice, "#", "")
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
		
	Gui Add, Picture, x+30 w-1 h30 gSettings, %Settings_Icon%
	; Goto, Settings
	Gui, Show, AutoSize, Pick a Video Player to Play "%File_Path%"
Return

;--------Settings (Gui 2)-------------------------------------------------
Settings:
Menu, tray, icon, %Settings_Icon%
	Gui, 1: Destroy
	; Gui, Margin, 10, 10
	Gui, Settings: +HWNDSettingsWindow +AlwaysOnTop +LastFound
	Gui, Settings: New
	
	Gui, Font, s11, Arial
	Gui, Settings: Add, Tab3,, Player Configuration|GUI Settings|About
	
	Gui, Tab, 1
		Gui, Settings: Add, Text, y+10, Enter the paths to the *.exe and *.ico files of your desired video players `n (You can also use the same *.exe path for icon.) `n
		
		Gui, Add, GroupBox, x25 yp+35 w640 h70 vGroupBox1
		Gui, Add, GroupBox, y+0 w640 h70 vGroupBox2
		Gui, Add, GroupBox, y+0 w640 h70 vGroupBox3
		Gui, Add, GroupBox, y+0 w640 h70 vGroupBox4
		Gui, Add, GroupBox, y+0 w640 h70 vGroupBox5

		GuiControlGet, GroupBox1, Pos
		GroupBox1Y+=15

		VerticalSpacing1:=49
		Gui, Settings: Add, Text, x30 y%GroupBox1Y% Section, Path to Player 1's .exe-
		Gui, Settings: Add, Text, xs y+5, Path to Player 1's Icon-
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing1%, Path to Player 2's .exe-
		Gui, Settings: Add, Text, xs y+4, Path to Player 2's Icon-
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing1%, Path to Player 3's .exe-
		Gui, Settings: Add, Text, xs y+3, Path to Player 3's Icon-
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing1%, Path to Player 4's .exe-
		Gui, Settings: Add, Text, xs y+6, Path to Player 4's Icon-
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing1%, Path to Player 5's .exe-
		Gui, Settings: Add, Text, xs y+5, Path to Player 5's Icon-
		
		VerticalSpacing2=50
		Gui, Settings: Add, Edit, vREG_Player1_Path x190 y%GroupBox1Y% w370 h20 Section, %Player1_Path%
		Gui, Settings: Add, Edit, vREG_Player1_Icon xs y+1 wp hp, %Player1_Icon%
		Gui, Settings: Add, Edit, vREG_Player2_Path xs yp+%VerticalSpacing2% wp hp, %Player2_Path%
		Gui, Settings: Add, Edit, vREG_Player2_Icon xs y+1 wp hp, %Player2_Icon%
		Gui, Settings: Add, Edit, vREG_Player3_Path xs yp+%VerticalSpacing2% wp hp, %Player3_Path%
		Gui, Settings: Add, Edit, vREG_Player3_Icon xs y+1 wp hp, %Player3_Icon%
		Gui, Settings: Add, Edit, vREG_Player4_Path xs yp+%VerticalSpacing2% wp hp, %Player4_Path%
		Gui, Settings: Add, Edit, vREG_Player4_Icon xs y+1 wp hp, %Player4_Icon%
		Gui, Settings: Add, Edit, vREG_Player5_Path xs yp+%VerticalSpacing2% wp hp, %Player5_Path%
		Gui, Settings: Add, Edit, vREG_Player5_Icon xs y+1 wp hp, %Player5_Icon%
		
		VerticalSpacing3:=50
		Gui, Settings: Add, Text, x580 y95 Section, Hotkey:
		Gui, Settings: Add, HotKey,xs y+1 w75 h20 vREG_Player1_Hotkey, %Player1_Hotkey%
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing3% wp hp, Hotkey:
		Gui, Settings: Add, HotKey, xs y+1 wp hp vREG_Player2_Hotkey, %Player2_Hotkey%
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing3% wp hp, Hotkey:
		Gui, Settings: Add, HotKey, xs y+1 wp hp vREG_Player3_Hotkey, %Player3_Hotkey%
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing3% wp hp, Hotkey:
		Gui, Settings: Add, HotKey, xs y+1 wp hp vREG_Player4_Hotkey, %Player4_Hotkey%
		Gui, Settings: Add, Text, xs yp+%VerticalSpacing3% wp hp, Hotkey:
		Gui, Settings: Add, HotKey, xs y+1 wp hp vREG_Player5_Hotkey, %Player5_Hotkey%
	
	
	Gui, Tab, 2
		Gui, Settings: Add, GroupBox, y+5 w630 h110 Section
		Gui, Settings: Add, Text,xs+5 ys+15 Section, Background Color:
		Gui, Settings: Add, ComboBox, x+10 ys w120 vREG_ColorChoice Simple, Black|White|Transparent|00FFFF|808080
		Gui, Settings: Add, Text, ys wrap w400, (You can also add your own 𝙃𝙚𝙭 𝘾𝙤𝙙𝙚 for any Color)
		Gui, Settings: Add, Link, , <a href="https://colorpicker.me/#000000">Go to Online Color Picker</a>
		Gui, Settings: Add, Text, xs+1 y+200 0x2, Many more options coming soon... Maybe?
		
		
	Gui, Tab, 3
		Gui, Settings: Add, GroupBox, x+85 y+25 w550 h250 Section Center
		Gui, Settings: Add, Picture, xs+15 ys+25 w-1 h200, %Main_Icon%
		Gui, Font, s26 w700, Comic Sans MS
		Gui, Settings: Add, Text, x+35 ys+55 center, Video Picker
		Gui, Font, s22 w600, Courier
		Gui, Settings: Add, Text, xp+5 yp+55 center, v%CurrentVersion%
		Gui, Font, s20 w200, Comic Sans MS
		Gui, Settings: Add, Text, y+20,~By Jery
		Gui, Font, s13 w600, Courier
		Gui, Settings: Add, Button, xs y+70, Check for Updates (coming soon)


	Gui, Tab
		Gui, Font, s11 w400, Arial
		Gui, Settings: Add, Button, x520 y460 w80, &Cancel
		Gui, Settings: Add, Button, Default x620 yp wp, &Submit
		Gui, Settings: Add, Text, x20 yp, File extension association: 
		Gui, Settings: Add, Button, x+10 yp+0 w200 h20 gSetUpAssociations, Set up associations...
		

	Gui, Settings: Show, w720 h500, Settings
Menu, tray, icon, %Main_Icon%
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
	Gui, Settings: Submit
	; MsgBox, "%REG_Player1_Hotkey%"`n"%REG_Player1_Path%"`n"%REG_Player1_Icon%"`n`n"%REG_Player2_Hotkey%"`n"%REG_Player2_Path%"`n"%REG_Player2_Icon%"`n`n"%REG_Player3_Hotkey%"`n"%REG_Player3_Path%"`n"%REG_Player3_Icon%"`n`n"%REG_Player4_Hotkey%"`n"%REG_Player4_Path%"`n"%REG_Player4_Icon%"`n`n"%REG_Player5_Hotkey%"`n"%REG_Player5_Path%"`n"%REG_Player5_Icon%"`n`n"%ColorChoice%"
	Ini_Write()	
	Gui, Settings: Destroy
	Goto, MainWindow
	Reload
Return
SetUpAssociations:
	Run, https://www.pcmag.com/how-to/how-to-customize-your-default-apps-in-windows-and-macos
	MsgBox, 64, Video Picker, On pressing 'Ok'`, you will be redirected to the "Set Default Programs" screen.`nHere`, select your preferred video formats (.mp4`, .avi`, .mkv`, .wmv`, etc) and set Video Picker as the default.`nIn case Video Picker is not Visible`, click "Choose an App" and manually locate "Video Picker.exe"
	Run, control /name Microsoft.DefaultPrograms
	REG_Default:="VideoPicker.Picker"
	RegWrite, REG_SZ, HKCR\.mp4,, %REG_Default%
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT\%REG_Default%\Shell\Open\command ,,"%A_ScriptFullPath%" "`%1"
Return

!s::Goto, Settings


#If
Esc::
GuiClose:
GuiEscape:
	FileDelete, %Main_Icon%
	FileDelete, %Settings_Icon%
	ExitApp
Return




;--------Ini Settings-------------------------------------------------
Ini_Read() {
FileCreateDir, %A_AppData%\Video_Picker
	IniRead, Player1_Hotkey, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Hotkey, 1
	IniRead, Player1_Path, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Path, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
	IniRead, Player1_Icon, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Icon, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
	If !RegExMatch(Player1_Path, ".exe")
	{
		IniWrite, %A_ProgramFiles%\Windows Media Player\wmplayer.exe, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Path
		IniWrite, %A_ProgramFiles%\Windows Media Player\wmplayer.exe, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Icon
	}
	
	IniRead, Player2_Hotkey, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Hotkey, 2
	IniRead, Player2_Path, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Path
	IniRead, Player2_Icon, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Icon

	IniRead, Player3_Hotkey, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Hotkey, 3
	IniRead, Player3_Path, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Path
	IniRead, Player3_Icon, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Icon

	IniRead, Player4_Hotkey, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Hotkey, 4
	IniRead, Player4_Path, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Path
	IniRead, Player4_Icon, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Icon

	IniRead, Player5_Hotkey, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Hotkey, 5
	IniRead, Player5_Path, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Path
	IniRead, Player5_Icon, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Icon
	
	IniRead, ColorChoice, %A_AppData%\Video_Picker\Video_Picker_Config.ini, GUI, ColorChoice
}

Ini_Write() {
FileCreateDir, %A_AppData%\Video_Picker
	; IniDelete, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1
	IniWrite, %REG_Player1_Hotkey%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Hotkey
	IniWrite, %REG_Player1_Path%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Path
	IniWrite, %REG_Player1_Icon%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_1, Player1_Icon

	; IniDelete, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2
	IniWrite, %REG_Player2_Hotkey%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Hotkey
	IniWrite, %REG_Player2_Path%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Path
	IniWrite, %REG_Player2_Icon%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_2, Player2_Icon

	; IniDelete, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3
	IniWrite, %REG_Player3_Hotkey%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Hotkey
	IniWrite, %REG_Player3_Path%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Path
	IniWrite, %REG_Player3_Icon%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_3, Player3_Icon

	; IniDelete, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4
	IniWrite, %REG_Player4_Hotkey%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Hotkey
	IniWrite, %REG_Player4_Path%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Path
	IniWrite, %REG_Player4_Icon%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_4, Player4_Icon

	; IniDelete, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5
	IniWrite, %REG_Player5_Hotkey%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Hotkey
	IniWrite, %REG_Player5_Path%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Path
	IniWrite, %REG_Player5_Icon%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, Player_5, Player5_Icon
	
	IniWrite, %REG_ColorChoice%, %A_AppData%\Video_Picker\Video_Picker_Config.ini, GUI, ColorChoice
}
Return