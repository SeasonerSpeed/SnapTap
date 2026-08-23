#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

enabled := true
appTitle := "Snap Tap"

; ---------- GUI ----------
myGui := Gui("+AlwaysOnTop -MaximizeBox -MinimizeBox", appTitle)
myGui.BackColor := "151515"
myGui.SetFont("s14 Bold", "Segoe UI")
title := myGui.AddText("x20 y18 w300 Center cFFFFFF", "SNAP TAP")

myGui.SetFont("s20 Bold", "Segoe UI")
status := myGui.AddText("x20 y55 w300 h45 Center", "ON")
status.SetFont("c55FF77")

myGui.SetFont("s9", "Segoe UI")
info := myGui.AddText("x20 y105 w300 h45 Center cAAAAAA", "F8 = Toggle`nClose this window to disable Snap Tap")

toggleBtn := myGui.AddButton("x85 y165 w170 h35", "Toggle (F8)")
toggleBtn.OnEvent("Click", Toggle)

myGui.OnEvent("Close", (*) => ExitApp())
myGui.Show("w340 h225")

; ---------- Hotkeys ----------
F8::Toggle()

Toggle(*) {
    global enabled, status
    enabled := !enabled

    if enabled {
        status.Text := "ON"
        status.SetFont("c55FF77")
    } else {
        status.Text := "OFF"
        status.SetFont("cFF5555")
        ReleaseKeys()
    }
}

ReleaseKeys() {
    Send "{a up}{d up}{w up}{s up}"
}

; ---------- Snap Tap ----------
$a:: {
    global enabled
    if !enabled {
        Send "{a down}"
        KeyWait "a"
        Send "{a up}"
        return
    }

    Send "{a down}"
    while GetKeyState("a", "P") {
        if GetKeyState("d", "P") {
            Send "{a up}{d down}"
            while GetKeyState("d", "P")
                Sleep 1
            Send "{d up}"
            if GetKeyState("a", "P")
                Send "{a down}"
        }
        Sleep 1
    }
    Send "{a up}"
}

$d:: {
    global enabled
    if !enabled {
        Send "{d down}"
        KeyWait "d"
        Send "{d up}"
        return
    }

    Send "{d down}"
    while GetKeyState("d", "P") {
        if GetKeyState("a", "P") {
            Send "{d up}{a down}"
            while GetKeyState("a", "P")
                Sleep 1
            Send "{a up}"
            if GetKeyState("d", "P")
                Send "{d down}"
        }
        Sleep 1
    }
    Send "{d up}"
}

$w:: {
    global enabled
    if !enabled {
        Send "{w down}"
        KeyWait "w"
        Send "{w up}"
        return
    }

    Send "{w down}"
    while GetKeyState("w", "P") {
        if GetKeyState("s", "P") {
            Send "{w up}{s down}"
            while GetKeyState("s", "P")
                Sleep 1
            Send "{s up}"
            if GetKeyState("w", "P")
                Send "{w down}"
        }
        Sleep 1
    }
    Send "{w up}"
}

$s:: {
    global enabled
    if !enabled {
        Send "{s down}"
        KeyWait "s"
        Send "{s up}"
        return
    }

    Send "{s down}"
    while GetKeyState("s", "P") {
        if GetKeyState("w", "P") {
            Send "{s up}{w down}"
            while GetKeyState("w", "P")
                Sleep 1
            Send "{w up}"
            if GetKeyState("s", "P")
                Send "{s down}"
        }
        Sleep 1
    }
    Send "{s up}"
}

OnExit((*) => ReleaseKeys())
