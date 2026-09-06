#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
; ============================================================
; SETTINGS
; ============================================================
settingsFile := A_ScriptDir "\SnapTap.ini"
startupShortcut := A_Startup "\SnapTap.lnk"
snapTapEnabled := true
runInBackground := IniRead(settingsFile, "Settings", "RunInBackground", "0") = "1"
; ============================================================
; GUI
; ============================================================
myGui := Gui("-MaximizeBox -MinimizeBox", "SnapTap")
myGui.BackColor := "151515"
myGui.SetFont("s18 Bold", "Segoe UI")
myGui.AddText(
    "x20 y15 w300 h35 Center cFFFFFF",
    "SNAP TAP"
)
myGui.SetFont("s10", "Segoe UI")
myGui.AddText(
    "x20 y55 w300 h25 Center c888888",
    "A/D + W/S Snap Tap"
)
status := myGui.AddText(
    "x20 y90 w300 h35 Center",
    "ON"
)
status.SetFont("s20 Bold c55FF77")
toggleButton := myGui.AddButton(
    "x90 y140 w160 h40",
    "Disable"
)
toggleButton.OnEvent(
    "Click",
    ToggleSnapTap
)
myGui.AddText(
    "x20 y195 w300 h40 Center c666666",
    "Use the button above or press F7 to toggle Snap Tap."
)
startupCheckbox := myGui.AddCheckbox(
    "x20 y245 w300 h25 cCCCCCC",
    "Run on Startup"
)
startupCheckbox.Value := FileExist(startupShortcut) ? 1 : 0
startupCheckbox.OnEvent(
    "Click",
    ToggleStartup
)
backgroundCheckbox := myGui.AddCheckbox(
    "x20 y275 w300 h25 cCCCCCC",
    "Run in Background"
)
backgroundCheckbox.Value := runInBackground ? 1 : 0
backgroundCheckbox.OnEvent(
    "Click",
    ToggleRunInBackground
)
myGui.OnEvent(
    "Close",
    GuiClose
)
if !runInBackground {
    myGui.Show(
        "w340 h320"
    )
}
; ============================================================
; TRAY
; ============================================================
A_TrayMenu.Add()
A_TrayMenu.Add(
    "Show SnapTap",
    ShowMainGui
)
A_TrayMenu.Default := "Show SnapTap"
ShowMainGui(*) {
    global myGui
    myGui.Show(
        "w340 h320"
    )
}
; ============================================================
; TOGGLE
; ============================================================
ToggleSnapTap(*) {
    global snapTapEnabled
    global status
    global toggleButton
    snapTapEnabled := !snapTapEnabled
    if snapTapEnabled {
        status.Text := "ON"
        status.SetFont("s20 Bold c55FF77")
        toggleButton.Text := "Disable"
    } else {
        status.Text := "OFF"
        status.SetFont("s20 Bold cFF5555")
        toggleButton.Text := "Enable"
        ReleaseKeys()
    }
}
F7::ToggleSnapTap()
; ============================================================
; RUN ON STARTUP
; ============================================================
ToggleStartup(ctrl, *) {
    global startupShortcut
    if ctrl.Value {
        try {
            FileCreateShortcut(A_ScriptFullPath, startupShortcut, A_ScriptDir)
        } catch {
            ctrl.Value := 0
            MsgBox("Couldn't create the startup shortcut.", "SnapTap")
        }
    } else {
        try FileDelete(startupShortcut)
    }
}
; ============================================================
; RUN IN BACKGROUND
; ============================================================
ToggleRunInBackground(ctrl, *) {
    global runInBackground
    global settingsFile
    runInBackground := ctrl.Value ? true : false
    try IniWrite(runInBackground ? "1" : "0", settingsFile, "Settings", "RunInBackground")
}
GuiClose(*) {
    global runInBackground
    global myGui
    if runInBackground {
        myGui.Hide()
    } else {
        ExitApp()
    }
}
; ============================================================
; A / D
; ============================================================
$a:: {
    global snapTapEnabled
    Send "{a down}"
    if snapTapEnabled {
        if GetKeyState("d", "P")
            Send "{d up}"
    }
}
$a up:: {
    global snapTapEnabled
    Send "{a up}"
    if snapTapEnabled {
        if GetKeyState("d", "P")
            Send "{d down}"
    }
}
$d:: {
    global snapTapEnabled
    Send "{d down}"
    if snapTapEnabled {
        if GetKeyState("a", "P")
            Send "{a up}"
    }
}
$d up:: {
    global snapTapEnabled
    Send "{d up}"
    if snapTapEnabled {
        if GetKeyState("a", "P")
            Send "{a down}"
    }
}
; ============================================================
; W / S
; ============================================================
$w:: {
    global snapTapEnabled
    Send "{w down}"
    if snapTapEnabled {
        if GetKeyState("s", "P")
            Send "{s up}"
    }
}
$w up:: {
    global snapTapEnabled
    Send "{w up}"
    if snapTapEnabled {
        if GetKeyState("s", "P")
            Send "{s down}"
    }
}
$s:: {
    global snapTapEnabled
    Send "{s down}"
    if snapTapEnabled {
        if GetKeyState("w", "P")
            Send "{w up}"
    }
}
$s up:: {
    global snapTapEnabled
    Send "{s up}"
    if snapTapEnabled {
        if GetKeyState("w", "P")
            Send "{w down}"
    }
}
; ============================================================
; CLEANUP
; ============================================================
ReleaseKeys() {
    Send "{a up}"
    Send "{d up}"
    Send "{w up}"
    Send "{s up}"
}
OnExit((*) => ReleaseKeys())
