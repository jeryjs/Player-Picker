;@Ahk2Exe-SetName		PlayerPicker
;@Ahk2Exe-ExeName	PlayerPicker
;@Ahk2Exe-SetProductName	PlayerPicker
;@Ahk2Exe-SetDescription	PlayerPicker
;@Ahk2Exe-SetVersion		v0.7.1-alpha
CurrentVersion := 		   "v0.7.1-alpha"
;@Ahk2Exe-SetCompanyName	Jery

;@Ahk2Exe-SetMainIcon Assets\PlayerPicker_Main.ico

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
SetWorkingDir %A_ScriptDir%
/*@Ahk2Exe-Keep
#Warn All, Off
#NoTrayIcon
*/

Global Temp := % A_Temp "\PlayerPicker"
FileCreateDir, %Temp%

Settings_Icon := % Temp "\PlayerPicker_Settings-Icon.ico"
Main_Icon := % Temp "\PlayerPicker_Main.ico"

FileInstall, assets\PlayerPicker_Main.ico, %Main_Icon%
FileInstall, assets\PlayerPicker_Settings-Icon.ico, %Settings_Icon%

Menu, tray, icon, %Main_Icon%

Global Player1_Hotkey, Global Player2_Hotkey, Global Player3_Hotkey, Global Player4_Hotkey, Global Player5_Hotkey
Global Player1_Path, Global Player2_Path, Global Player3_Path, Global Player4_Path, Global Player5_Path
Global Player1_Icon, Global Player2_Icon, Global Player3_Icon, Global Player4_Icon, Global Player5_Icon

Global REG_Player1_Hotkey, Global REG_Player2_Hotkey, Global REG_Player3_Hotkey, Global REG_Player4_Hotkey, Global REG_Player5_Hotkey
Global REG_Player1_Path, Global REG_Player2_Path, Global REG_Player3_Path, Global REG_Player4_Path, Global REG_Player5_Path
Global REG_Player1_Icon, Global REG_Player2_Icon, Global REG_Player3_Icon, Global REG_Player4_Icon, Global REG_Player5_Icon

Global ColorChoice, Global REG_ColorChoice, Global Settings_Hotkey, Global REG_Settings_Hotkey, Global Icon_Size, Global REG_Icon_Size
Global File_Path

Ini_Read()

; Create proper file path in case the path contains spaces
Loop, %0%
   param .= %A_Index% A_Space
File_Path := Trim(param)


;--------Hotkeys-------------------------------------------------
; #If (WinExist("Pick a Video Player to Play") AND !WinExist("Settings"))
Hotkey, IfWinNotExist, Settings
Hotkey, %Player1_Hotkey%, Player1
Hotkey, %Player2_Hotkey%, Player2
Hotkey, %Player3_Hotkey%, Player3
Hotkey, %Player4_Hotkey%, Player4
Hotkey, %Player5_Hotkey%, Player5
Hotkey, %Settings_Hotkey%, Settings
#If


;--------MainWindow (GUI 1)-------------------------------------------------
MainWindow:
Ini_Read()
; MsgBox, "%Player1_Hotkey%"`n"%Player1_Path%"`n"%Player1_Icon%"`n`n"%Player2_Hotkey%"`n"%Player2_Path%"`n"%Player2_Icon%"`n`n"%Player3_Hotkey%"`n"%Player3_Path%"`n"%Player3_Icon%"`n`n"%Player4_Hotkey%"`n"%Player4_Path%"`n"%Player4_Icon%"`n`n"%Player5_Hotkey%"`n"%Player5_Path%"`n"%Player5_Icon%"`n`n"%ColorChoice%"
	Gui, Main: New
	Gui, Main: Default
	Gui, +Owner%scHwnd% +HWNDMainWindow +LastFound +AlwaysOnTop +ToolWindow
	
	If (ColorChoice = "ERROR")
		ColorChoice := "Black"
	If (ColorChoice = "Transparent")
		ColorChoice := 1
	Gui, Color, % RegExReplace(ColorChoice, "#", "")
	WinSet, TransColor, 1 240

	If (Player1_Icon != "ERROR")
		Gui, Add, Picture, x0 w-1 h%Icon_Size% gPlayer1, %Player1_Icon%
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
	Gui, Main: Destroy
	Gui, Settings: +HWNDSettingsWindow +AlwaysOnTop +LastFound
	Gui, Settings: New
	
	Gui, Font, s11, Arial
	Gui, Settings: Add, Tab3,, Player Configuration|GUI Settings|About
	
	Gui, Tab, 1
		Gui, Settings: Add, Text, y+10, Enter the paths to the *.exe and icon files of your desired video players `n (You can also use the same *.exe path for icon.) `n
		
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
		Gui, Settings: Add, GroupBox, x25 y+5 w630 h300 Section
		Gui, Settings: Add, Text,xs+5 ys+15, Background Color:
		Gui, Settings: Add, ComboBox, x+10 yp r4 w120 vREG_ColorChoice Simple, %ColorChoice%||Black|White|Transparent|00FFFF|808080
		Gui, Settings: Add, Text, xp+150 yp wrap w400, (You can also add your own Hex Code for any Color)
		Gui, Settings: Add, Link,, <a href="https://colorpicker.me/#000000">Go to Online Color Picker</a>
		
		Gui, Settings: Add, Text, xs+5 yp+100, Hotkey to open Settings: 
		Gui, Settings: Add, Hotkey, x+10 yp-2 w120 vREG_Settings_Hotkey, %Settings_Hotkey%
		
		Gui, Settings: Add, Text, xs+5 yp+60, Set Player Icons Size:
		Gui, Settings: Add, Edit, x+10 yp-2 w120 vREG_Icon_Size, %Icon_Size%
		Gui, Settings: Add, UpDown, Range10-300, %Icon_Size%
		
		Gui, Settings: Add, Text, xs+1 y+150 0x2, Many more options coming soon... Maybe?
		
		
	Gui, Tab, 3
		Gui, Settings: Add, GroupBox, x+85 y+25 w550 h250 Section Center
		Gui, Settings: Add, Picture, xs+15 ys+25 w-1 h200, %Main_Icon%
		Gui, Font, s26 w700, Comic Sans MS
		Gui, Settings: Add, Text, x+35 ys+55 center, Player Picker
		Gui, Font, s22 w600, Courier
		Gui, Settings: Add, Text, xp+5 yp+55 center, %CurrentVersion%
		Gui, Font, s20 w200, Comic Sans MS
		Gui, Settings: Add, Text, y+20,~By Jery
		Gui, Font, s13 w600, Courier
		Gui, Settings: Add, Button, xs y+70 gCheckForUpdates, Check for Updates


	Gui, Tab
		Gui, Font, s11 w400, Arial
		Gui, Settings: Add, Button, x520 y460 w80, &Cancel
		Gui, Settings: Add, Button, Default x620 yp wp, &Save
		Gui, Settings: Add, Text, x20 yp, File extension association: 
		Gui, Settings: Add, Button, x+10 yp+0 w200 h20 gSetUpAssociations, Set up associations...
		

	Gui, Settings: Show, w720 h500, Settings
Menu, tray, icon, %Main_Icon%
Return

;--------FTA (Gui 3)-------------------------------------------------
SetUpAssociations:
	Gui, Settings: +Disabled
	Gui, FTA: New
	Gui, Font, s11, Arial
	Gui, FTA: +OwnerSettings
	Gui, FTA: Add, Button, w220 h25	gRegisterExts, Register File Associations
	Gui, FTA: Add, Button, wp hp gUnRegisterExts, Un-Register File Associations
	Gui, FTA: Add, Button, x100 y+15 gFTAButtonClose, &Close

	Gui, FTA: Show
Return

;-----------------------------------------------------------------
#If
Esc::
MainGuiClose:
MainGuiEscape:
	ExitApp()
Return

;SubRoutines for GUI 1 (MainWindow)
Player1:
	Player("1")
Return
Player2:
	Player("2")
Return
Player3:
	Player("3")
Return
Player4:
	Player("4")
Return
Player5:
	Player("5")
Return


Player(n) {		; Run Player with additional Context
	Gui, Hide
	Suspend, On
	Player_Path := Player%n%_Path
	If RegExMatch(Player%n%_Path, ".exe")
		Run, "%Player_Path%" -- "%File_Path%"
	Else
		MsgBox, 48, Player Picker, Add the path to the video player's exe in settings first
	Gui, Main: Destroy
	RegExMatch(Player_Path, "([\w\d\s]+\.exe$)", Match)
	Loop, 10 {	; wait for the player to open
		IfWinExist, ahk_exe %Match%
			Break
		Sleep, 300
	}
		If(Match = "mpv.net")
			Sleep, 2000
		ControlSend, , {Enter}, mpv.net	;fix potential bug in mpvnet
		WinActivate, ahk_exe %Match%
	ExitApp()
	}
Return


;SubRoutines for GUI 2 (SETTINGS)
SettingsButtonCancel:
	Gui, Settings: Cancel
	Gui, Settings: Destroy
	Goto, MainWindow
Return
SettingsButtonSave:
	Gui, Settings: Submit
	; MsgBox, "%REG_Player1_Hotkey%"`n"%REG_Player1_Path%"`n"%REG_Player1_Icon%"`n`n"%REG_Player2_Hotkey%"`n"%REG_Player2_Path%"`n"%REG_Player2_Icon%"`n`n"%REG_Player3_Hotkey%"`n"%REG_Player3_Path%"`n"%REG_Player3_Icon%"`n`n"%REG_Player4_Hotkey%"`n"%REG_Player4_Path%"`n"%REG_Player4_Icon%"`n`n"%REG_Player5_Hotkey%"`n"%REG_Player5_Path%"`n"%REG_Player5_Icon%"`n`n"%ColorChoice%"
	Ini_Write()	
	Gui, Settings: Destroy
	Goto, MainWindow
	Reload
Return

CheckForUpdates:
	DownloadFile("https://github.com/jeryjs/Player-Picker/releases", Temp "\Source.html",,, True)
		Progress, Off
		FileReadLine, Version, %Temp%\Source.html, 966
		Gui +OwnDialogs
		NewVersion := RegExReplace(Version, " ", "")
		If !(NewVersion > CurrentVersion)
			MsgBox, 64, Update not Found!, You are on the latest versiont: %CurrentVersion%
		Else
			MsgBox, 49, Update Found!, Your Current Version is: %CurrentVersion%`nUpdate to the latest version %NewVersion%?
			IfMsgBox Ok
			{
				Gui +OwnDialogs
				DownloadFile("https://github.com/jeryjs/Player-Picker/releases/download/" NewVersion "/PlayerPicker.exe", Temp "\Update.exe")
				Progress, Off
				/*@Ahk2Exe-Keep
					FileAppend, @echo off `n xcopy "%Temp%\Update.exe" "%A_ScriptFullPath%" /H /Y `n Start ""  "%A_ScriptFullPath%" `n DEL "`%~f0" & EXIT, %Temp%\Update.bat
					MsgBox, 64, Update, Player Picker will now close to apply the new update. `nPlease wait for a moment.
					Run, %Temp%\Update.bat
					ExitApp
				*/
			}
			
Return

;SubRoutines for GUI 3 (FTA)
FTAButtonClose:
	Gui, Settings: -Disabled
	Gui, FTA: Destroy
Return


;--------Ini Settings-------------------------------------------------
Ini_Read() {
FileCreateDir, %A_AppData%\Player_Picker
	IniRead, Player1_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Hotkey, 1
	IniRead, Player1_Path, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Path, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
	IniRead, Player1_Icon, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Icon, %A_ProgramFiles%\Windows Media Player\wmplayer.exe
		If !RegExMatch(Player1_Path, ".exe")
		{
			IniWrite, %A_ProgramFiles%\Windows Media Player\wmplayer.exe, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Path
			IniWrite, %A_ProgramFiles%\Windows Media Player\wmplayer.exe, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Icon
		}
	
	IniRead, Player2_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Hotkey, 2
	IniRead, Player2_Path, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Path
	IniRead, Player2_Icon, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Icon

	IniRead, Player3_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Hotkey, 3
	IniRead, Player3_Path, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Path
	IniRead, Player3_Icon, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Icon

	IniRead, Player4_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Hotkey, 4
	IniRead, Player4_Path, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Path
	IniRead, Player4_Icon, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Icon

	IniRead, Player5_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Hotkey, 5
	IniRead, Player5_Path, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Path
	IniRead, Player5_Icon, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Icon
	
	IniRead, ColorChoice, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, ColorChoice
	IniRead, Settings_Hotkey, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, Settings_Hotkey, o
	IniRead, Icon_Size, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, Icon_Size, 80
		If Icon_Size > 300
			Icon_Size := 300
		If Icon_Size < 10
			Icon_Size := 10
}

Ini_Write() {
FileCreateDir, %A_AppData%\Player_Picker
	IniWrite, %REG_Player1_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Hotkey
	IniWrite, %REG_Player1_Path%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Path
	IniWrite, %REG_Player1_Icon%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_1, Player1_Icon

	IniWrite, %REG_Player2_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Hotkey
	IniWrite, %REG_Player2_Path%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Path
	IniWrite, %REG_Player2_Icon%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_2, Player2_Icon

	IniWrite, %REG_Player3_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Hotkey
	IniWrite, %REG_Player3_Path%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Path
	IniWrite, %REG_Player3_Icon%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_3, Player3_Icon

	IniWrite, %REG_Player4_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Hotkey
	IniWrite, %REG_Player4_Path%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Path
	IniWrite, %REG_Player4_Icon%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_4, Player4_Icon

	IniWrite, %REG_Player5_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Hotkey
	IniWrite, %REG_Player5_Path%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Path
	IniWrite, %REG_Player5_Icon%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, Player_5, Player5_Icon
	
	IniWrite, %REG_ColorChoice%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, ColorChoice
	IniWrite, %REG_Settings_Hotkey%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, Settings_Hotkey
	IniWrite, %REG_Icon_Size%, %A_AppData%\Player_Picker\Player_Picker_Config.ini, GUI, Icon_Size
}
Return



;--------------Download File--------------------------------------------------
DownloadFile(UrlToFile, SaveFileAs, Overwrite := True, UseProgressBar := True, UnknownFileSize := False) {
		Global DownloaderTitle := PlayerPicker %CurrentVersion%
		If (!Overwrite && FileExist(SaveFileAs))
		  Return
		If (UseProgressBar) {
			WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			WebRequest.Open("HEAD", UrlToFile)
			WebRequest.Send()
			If (UnknownFileSize)
			{
				FinalSize := 135000		; The size of the source.html file, but it can change
				Progress, H80, , Checking for Update..., %DownloaderTitle%
			} Else {
				FinalSize := WebRequest.GetResponseHeader("Content-Length")
				Progress, H80, , Downloading..., %DownloaderTitle%
			}
			SetTimer, __UpdateProgressBar, 100
		}
		UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
		If ErrorLevel = 1
			MsgBox, 16, Player Picker, There was an error downloading the update. Please check your network connection and try again or download the update manually from: https://github.com/jeryjs/Player-Picker/releases
		Else {
			If (UseProgressBar) {
			  Progress, Off
			  SetTimer, __UpdateProgressBar, Off
			}
		}
    Return
	
    __UpdateProgressBar:
		CurrentSize := FileOpen(SaveFileAs, "r").Length
		CurrentSizeTick := A_TickCount
		Speed := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000)) . " Kb/s"
		LastSizeTick := CurrentSizeTick
		LastSize := FileOpen(SaveFileAs, "r").Length
		PercentDone := Round(CurrentSize/FinalSize*100)
		If (UnknownFileSize)
			Progress, %PercentDone%, %PercentDone%`% Done, Checking for Update...  (%Speed%), Checking for Update %DownloaderTitle% (%PercentDone%`%)
		Else
			Progress, %PercentDone%, %PercentDone%`% Done, Downloading...  (%Speed%), Downloading %DownloaderTitle% (%PercentDone%`%)
    Return
}


;--------------Register Extension--------------------------------------------------
RegisterExts:
FileDelete, %Temp%\Register Extensions.bat
#Include assets\Register Extensions.txt		;write a bat file to %Temp%
/*@Ahk2Exe-Keep
	Run, *RunAs %Temp%\Register Extensions.bat, UseErrorLevel
*/
Return

;--------------UnRegister Extension--------------------------------------------------
UnRegisterExts:
FileDelete, %Temp%\UnRegister Extensions.bat
#Include assets\UnRegister Extensions.txt	;write a bat file to %Temp%
/*@Ahk2Exe-Keep
	Run, *RunAs %Temp%\UnRegister Extensions.bat, UseErrorLevel
*/
Return




ExitApp() {
	FileDelete, %Main_Icon%
	FileDelete, %Settings_Icon%
	FileDelete, %Temp%\Source.html
	FileDelete, %Temp%\Update.exe
	FileDelete, %Temp%\Register Extensions.bat
	FileDelete, %Temp%\UnRegister Extensions.bat
	FileRemoveDir, %Temp%, 1
ExitApp
}
