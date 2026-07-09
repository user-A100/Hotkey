# AutoHotkey 操作指南

## 1. 什么是 AutoHotkey

AutoHotkey（AHK）是一款 Windows 平台上的自动化脚本工具，可以用来：
- 创建自定义快捷键
- 自动化重复操作
- 控制窗口和程序
- 模拟键盘鼠标输入

---

## 2. 版本说明

本项目使用 **AutoHotkey v2.0**（保存在 `v2/` 目录下）。

| 文件 | 用途 |
|------|------|
| `v2/AutoHotkey64.exe` | 64位主程序 |
| `v2/AutoHotkey32.exe` | 32位主程序 |
| `v2/AutoHotkey.exe` | 自动选择对应架构 |
| `v2/AutoHotkey.chm` | 帮助文档 |

**v1 和 v2 语法不兼容**，本指南全部使用 v2 语法。

---

## 3. 如何运行脚本

### 3.1 双击运行
直接双击 `.ahk` 文件，系统会自动调用 AutoHotkey 运行。

### 3.2 用指定版本运行
```
d:\Autohotkey\v2\AutoHotkey64.exe 脚本文件.ahk
```

### 3.3 重新加载正在运行的脚本
右键点击系统托盘中的 AHK 图标（绿色 H），选择 **Reload This Script**。

### 3.4 退出脚本
右键点击托盘图标，选择 **Exit**。

---

## 4. 脚本基本结构

```autohotkey
#Requires AutoHotkey v2.0      ; 声明使用 v2 版本
#SingleInstance Force           ; 只允许一个实例运行

; 这是注释
; 快捷键定义
^!h:: {                         ; Ctrl+Alt+H
    MsgBox("Hello World!")
}
```

---

## 5. 常用快捷键定义

| 符号 | 含义 | 示例 |
|------|------|------|
| `^` | Ctrl | `^c` = Ctrl+C |
| `!` | Alt | `!f` = Alt+F |
| `#` | Win | `#z` = Win+Z |
| `+` | Shift | `+a` = Shift+A |
| `~` | 不屏蔽原按键 | `~a` = 按下 a 时触发，a 本身照常工作 |

**组合键示例：**
```autohotkey
^!h:: MsgBox("Ctrl+Alt+H 被按下")     ; Ctrl+Alt+H
#z:: MsgBox("Win+Z 被按下")            ; Win+Z
^+s:: MsgBox("Ctrl+Shift+S 被按下")    ; Ctrl+Shift+S
```

---

## 6. 常用命令

### 6.1 Run — 运行程序
```autohotkey
Run("C:\path\to\program.exe")
Run("notepad.exe")
Run("https://www.google.com")         ; 打开网址
```

### 6.2 MsgBox — 弹窗提示
```autohotkey
MsgBox("操作完成！")
MsgBox("错误信息", "错误标题", "IconX")
```

### 6.3 ToolTip — 屏幕浮动提示
```autohotkey
ToolTip("正在处理...")
SetTimer () => ToolTip(), -2000      ; 2秒后自动消失
```

### 6.4 Sleep — 等待
```autohotkey
Sleep(1000)           ; 等待 1 秒（单位：毫秒）
```

### 6.5 Send — 模拟按键
```autohotkey
Send("Hello")         ; 发送文字
Send("{Enter}")       ; 发送回车键
Send("{Tab}")         ; 发送 Tab 键
Send("{Space}")       ; 发送空格键
Send("^c")            ; 发送 Ctrl+C
```

### 6.6 窗口操作
```autohotkey
WinWait("窗口标题", , 5)              ; 等待窗口出现（最多5秒）
WinActivate("窗口标题")               ; 激活窗口
WinClose("窗口标题")                  ; 关闭窗口
```

### 6.7 控件操作
```autohotkey
ControlClick("控件文本", "窗口标题")  ; 点击控件
ControlGetHwnd("控件文本", "窗口标题") ; 获取控件句柄
```

### 6.8 INI 文件读写
```autohotkey
value := IniRead("config.ini", "Section", "Key", "默认值")
IniWrite("新值", "config.ini", "Section", "Key")
```

### 6.9 文件操作
```autohotkey
FileExist("C:\path\to\file.txt")      ; 检查文件是否存在
FileRead("C:\path\to\file.txt")       ; 读取文件内容
FileAppend("内容", "file.txt")        ; 追加内容到文件
```

---

## 7. 实战示例：AutoHideDesktopIcons 切换脚本

### 7.1 场景说明
- 程序路径：`C:\Users\111222\AppData\Local\Temp\...\AutoHideDesktopIcons_p.exe`
- 配置文件：同目录下的 `AutoHideDesktopIcons_p.ini`
- 核心配置项：`[Program]` 下的 `disable_permanently`（0=关闭，1=开启）

### 7.2 脚本代码

```autohotkey
#Requires AutoHotkey v2.0
#SingleInstance Force

iniPath := "C:\Users\111222\AppData\Local\Temp\0b66147d-90c4-4208-9a4b-b7ee25e3d443_AutoHideDesktopIcons_Portable.zip.443\AutoHideDesktopIcons_p.ini"
exePath := "C:\Users\111222\AppData\Local\Temp\0b66147d-90c4-4208-9a4b-b7ee25e3d443_AutoHideDesktopIcons_Portable.zip.443\AutoHideDesktopIcons_p.exe"

^!h:: {
    ; 读取当前状态
    currentVal := IniRead(iniPath, "Program", "disable_permanently", 0)

    ; 切换：0→1 或 1→0
    newVal := (currentVal = 1) ? 0 : 1

    ; 写入新值
    IniWrite(newVal, iniPath, "Program", "disable_permanently")

    ; 提示
    state := (newVal = 1) ? "ON - 永久隐藏桌面图标" : "OFF - 显示桌面图标"
    ToolTip(state)
    SetTimer () => ToolTip(), -2000

    ; 运行程序使其生效
    try Run(exePath)
}
```

### 7.3 工作原理
1. 按 `Ctrl+Alt+H`
2. 读取 INI 文件中 `disable_permanently` 的当前值
3. 在 0（关闭）和 1（开启）之间切换
4. 将新值写回 INI 文件
5. 运行程序，程序读取 INI 后生效
6. 屏幕显示当前状态提示

---

## 8. 开机自启动

### 8.1 方法一：创建快捷方式（推荐）
将脚本的快捷方式放入 Startup 文件夹：
```
C:\Users\用户名\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
```

快捷方式的目标：
```
"d:\Autohotkey\v2\AutoHotkey64.exe" "d:\Autohotkey\ToggleHideDesktopIcons.ahk"
```

### 8.2 方法二：任务计划程序
使用 `taskschd.msc` 创建任务，触发器设为"登录时"，操作设为运行脚本。

### 8.3 方法三：注册表
在 `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` 中添加字符串值。

---

## 9. 调试技巧

### 9.1 检查脚本是否在运行
查看系统托盘是否有绿色 H 图标。

### 9.2 使用 ToolTip 确认按键触发
```autohotkey
^!h:: {
    ToolTip("快捷键被触发！")
    SetTimer () => ToolTip(), -2000
}
```

### 9.3 使用 MsgBox 查看变量值
```autohotkey
^!h:: {
    value := IniRead(iniPath, "Program", "disable_permanently", 0)
    MsgBox("当前值: " . value)
}
```

### 9.4 检查语法错误
```cmd
"d:\Autohotkey\v2\AutoHotkey64.exe" /iLib nul "脚本.ahk"
```
无输出 = 语法正确；有输出 = 有错误。

### 9.5 快捷键不生效的常见原因
- **冲突**：其他程序（如显卡驱动、截图工具）占用了该组合键
- **权限**：某些程序需要以管理员身份运行 AHK
- **脚本未加载**：检查托盘图标是否存在
- **语法错误**：脚本加载失败，用 `/iLib` 检查

---

## 10. 常见问题

| 问题 | 解决方案 |
|------|----------|
| 脚本双击后没反应 | 检查是否已安装 AHK，或直接用 `AutoHotkey64.exe` 打开 |
| 快捷键被拦截 | 换一个组合键，如 `Ctrl+Alt+某个键` 冲突较少 |
| Run 程序没打开 | 用完整路径，或用 `SetWorkingDir` 指定工作目录 |
| ControlClick 无效 | 控件可能不是标准 Windows 控件，改用 INI 文件或坐标点击 |
| 中文路径乱码 | 保存脚本时使用 UTF-8 with BOM 编码 |
| 开机自启没生效 | 检查 Startup 文件夹快捷方式是否正确 |

---

## 11. 更多资源

- 官方文档：`v2/AutoHotkey.chm`（双击打开）
- 在线文档：https://www.autohotkey.com/docs/v2/
- 窗口信息查看工具：`WindowSpy.ahk`（用于查看窗口标题、控件信息等）