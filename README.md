# 🛠️ AutoHotkey 工具集

[![GitHub release](https://img.shields.io/github/v/release/user-A100/Hotkey)](https://github.com/user-A100/Hotkey/releases)
[![GitHub stars](https://img.shields.io/github/stars/user-A100/Hotkey)](https://github.com/user-A100/Hotkey/stargazers)

一套实用的 AutoHotkey 脚本工具，帮助你提高 Windows 操作效率。

---

## 📦 包含工具

| 工具 | 文件 | 快捷键 | 功能说明 |
|------|------|--------|----------|
| **快速隐藏桌面** | `hide.ahk` | `Win + H` | 一键隐藏/显示所有桌面图标和任务栏 |
| **快速息屏** | `close.ahk` | `Win + S` | 一键关闭显示器，移动鼠标或按任意键唤醒 |

---

## 🚀 快速开始

### 方法一：安装AutoHotkey后运行脚本（推荐）

1. **安装 AutoHotkey**
   - 运行本仓库中的 `AutoHotkey_2.0.26_setup.exe`
   - 或从官网下载：https://www.autohotkey.com/

2. **运行脚本**
   - 双击 `hide.ahk` 或 `close.ahk` 即可运行
   - 脚本会驻留在系统托盘（右下角）

3. **使用快捷键**
   - `Win + H`：隐藏/显示桌面
   - `Win + S`：息屏

### 方法二：编译成EXE（无需安装AutoHotkey）

如果想在没有安装AutoHotkey的电脑上使用，可以编译成EXE文件：

```bash
# 编译 hide.ahk
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "hide.ahk" /out "hide.exe"

# 编译 close.ahk
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "close.ahk" /out "close.exe"
