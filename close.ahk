#Requires AutoHotkey v2.0
#SingleInstance Force

LastEnterTime := 0

~Enter::
~NumpadEnter::
{
    global LastEnterTime

    now := A_TickCount

    if (now - LastEnterTime < 300)
    {
        LastEnterTime := 0

        ; 稍微延迟一点再息屏，让热键线程先结束
        SetTimer(TurnOffMonitor, -10)
        return
    }

    LastEnterTime := now
}

TurnOffMonitor()
{
    ; 用 PostMessageW（异步）替代 SendMessage（同步）
    ; SendMessage 向 HWND_BROADCAST 同步发送，若某窗口无响应会阻塞线程
    ; 导致脚本"卡死"，第二次双击 Enter 无法触发
    DllCall("user32.dll\PostMessageW"
        , "Ptr", 0xFFFF
        , "UInt", 0x0112
        , "Ptr", 0xF170
        , "Ptr", 2)
}
