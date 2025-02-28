#Requires AutoHotkey v2.0
; recommended for performance and compatibility with future autohotkey releases.
#UseHook
#SingleInstance force

InstallKeybdHook()

SendMode "Input"

;; deactivate capslock completely
SetCapslockState("AlwaysOff")

global CapslockIsDown := false

SetTimer(HandleCapslock, 50)

HandleCapslock() {
    global CapslockIsDown

    if (!CapslockIsDown && GetKeyState("Capslock", "P")) {
        CapslockIsDown := true
        Send("{Ctrl DownTemp}{Alt DownTemp}{LWin DownTemp}")
    } else if (CapslockIsDown && !GetKeyState("Capslock", "P")) {
        CapslockIsDown := false
        Send("{Ctrl Up}{Alt Up}{LWin Up}")
		;MsgBox("A_PriorKey: " . A_PriorKey)
        if (A_PriorKey == "CapsLock") {
            Send("{Esc}")
        }
    }
}

;; vim navigation with hyper
Hotkey "~Capslock & h", SendLeft
Hotkey "~Capslock & l", SendRight
Hotkey "~Capslock & k", SendUp
Hotkey "~Capslock & j", SendDown

SendLeft(ThisHotkey) {
    Send("{Left}")
}

SendRight(ThisHotkey) {
    Send("{Right}")
}

SendUp(ThisHotkey) {
    Send("{Up}")
}

SendDown(ThisHotkey) {
    Send("{Down}")
}

~LAlt Up::{
    if (A_PriorKey = "LAlt") {
        Send("{Esc}")
    }
}
