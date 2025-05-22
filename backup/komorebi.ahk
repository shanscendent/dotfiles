#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

^!#q::Komorebic("close")
^!#m::Komorebic("minimize")

; Focus windows
^!#a::Komorebic("focus left")
^!#s::Komorebic("focus down")
^!#w::Komorebic("focus up")
^!#d::Komorebic("focus right")

^!#+[::Komorebic("cycle-focus previous")
^!#+]::Komorebic("cycle-focus next")

; Move windows
^!#+a::Komorebic("move left")
^!#+s::Komorebic("move down")
^!#+w::Komorebic("move up")
^!#+d::Komorebic("move right")

; Stack windows
^!#Left::Komorebic("stack left")
^!#Down::Komorebic("stack down")
^!#Up::Komorebic("stack up")
^!#Right::Komorebic("stack right")
^!#e::Komorebic("unstack")
^!#[::Komorebic("cycle-stack previous")
^!#]::Komorebic("cycle-stack next")
^!#Tab::Komorebic("cycle-stack next")

; Resize
^!#=::Komorebic("resize-axis horizontal increase")
^!#-::Komorebic("resize-axis horizontal decrease")
^!#+=::Komorebic("resize-axis vertical increase")
^!#+_::Komorebic("resize-axis vertical decrease")

; Manipulate windows
^!#t::Komorebic("toggle-float")
^!#f::Komorebic("toggle-monocle")

; Window manager options
^!#r::Komorebic("retile")
^!#p::Komorebic("toggle-pause")

; Layouts
^!#x::Komorebic("flip-layout horizontal")
^!#c::Komorebic("flip-layout vertical")

; Workspaces
^!#1::Komorebic("focus-workspace 0")
^!#2::Komorebic("focus-workspace 1")
^!#3::Komorebic("focus-workspace 2")
^!#4::Komorebic("focus-workspace 3")
^!#5::Komorebic("focus-workspace 4")
^!#6::Komorebic("focus-workspace 5")

; Move windows across workspaces
^!#+1::Komorebic("move-to-workspace 0")
^!#+2::Komorebic("move-to-workspace 1")
^!#+3::Komorebic("move-to-workspace 2")
^!#+4::Komorebic("move-to-workspace 3")
^!#+5::Komorebic("move-to-workspace 4")
^!#+6::Komorebic("move-to-workspace 5")

; Monitors
^!#7::Komorebic("focus-monitor 0")
^!#8::Komorebic("focus-monitor 1")
^!#9::Komorebic("focus-monitor 2")
^!#0::Komorebic("focus-monitor 3")
^!#+7::Komorebic("send-to-monitor 0")
^!#+8::Komorebic("send-to-monitor 1")
^!#+9::Komorebic("send-to-monitor 2")
^!#+0::Komorebic("send-to-monitor 3")
