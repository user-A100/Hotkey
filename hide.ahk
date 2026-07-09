#Requires AutoHotkey v2.0
#SingleInstance Force

~Enter::
~NumpadEnter::
{
    if !(A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 300)
        return

    DllCall("SendMessage"
        , "Ptr", 0xFFFF      ; HWND_BROADCAST
        , "UInt", 0x0112     ; WM_SYSCOMMAND
        , "Ptr", 0xF170      ; SC_MONITORPOWER
        , "Ptr", 2)          ; 关闭显示器
}