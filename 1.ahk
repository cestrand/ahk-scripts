#NoEnv
#UseHook off
#InstallKeybdHook
#SingleInstance force
#Persistent

SendMode Input
SetCapslockState, AlwaysOff

#include <VA>

PlayEffect()
{
	Muted := VA_GetMasterMute("capture")
	if (Muted) {
		SoundPlay, mute.wav
	} else {
		SoundPlay, unmute.wav
	}
}

SetTimer, DismissTooltip, 60000

DismissTooltip:
  MouseMove, 1, 0, 50, R
return


;SetTimer, HideIrritatingWindows, 100

Media_Play_Pause::
  WasMuted := VA_GetMasterMute("capture")
  VA_SetMasterMute(!WasMuted, "capture")
  PlayEffect()
  Muted := !WasMuted
return

HideIrritatingWindows:
  WinHide, ahk_class QualysPatchDlgClass
return


Capslock::LControl

#IfWinActive emacs
LCtrl::APPSKEY
PrintScreen::SC664
#IfWinActive

#IfWinNotActive emacs
PrintScreen::
  IfWinExist emacs
  {
    WinActivate emacs
  }
  IfWinNotExist emacs
  {
    Run, "D:\Software\emacs-27.1-x86_64\bin\runemacs.exe"
    WinWait emacs
    WinActivate emacs
  }
return
#IfWinNotActive

DetectHiddenWindows 1

^+1::
{
  global topwindows
  topwindows.push(WinActive(A))
  WinSet, AlwaysOnTop, 1, A
  WinSet, ExStyle, +0x20, A
  WinSet, Transparent, 80, A
  return
}

^+2::
{
  global topwindows
  topwindows.push("eee")
  WinSet, AlwaysOnTop, 1, A
  WinSet, ExStyle, +0x20, A
  WinSet, Transparent, 160, A
  return
}

^+3::
{
  WinGet,Windows,List
  Loop,%Windows%
  {
	this_id := "ahk_id " . Windows%A_Index%
	WinSet, AlwaysOnTop, 0, %this_id%
        WinSet, Transparent, 255, %this_id%
        WinSet, ExStyle, -0x20, %this_id%
  }
  return
}

<^F11::Run "C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe"
<^F12::Run, PowerShell -NoExit C:\Users\marcin.kolenda\Documents\bin\runpsh.ps1
<^F8::Run D:\msys64\msys2_shell.cmd
<^F9::Run, PowerShell C:\Users\marcin.kolenda\Documents\bin\runbash.ps1
#w::Run D:\Far30b5888.x64.20210919\Far.exe C:\Users\marcin.kolenda\Downloads C:\Users\marcin.kolenda\Documents
