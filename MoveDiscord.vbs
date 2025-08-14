Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

tempPath = fso.GetSpecialFolder(2)
psFile = tempPath & "\MoveDiscordTemp.ps1"

Set file = fso.CreateTextFile(psFile, True)

file.WriteLine "Add-Type @'"
file.WriteLine "using System;"
file.WriteLine "using System.Runtime.InteropServices;"
file.WriteLine "public class Win32 {"
file.WriteLine "    [DllImport(""user32.dll"")]"
file.WriteLine "    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);"
file.WriteLine "    [DllImport(""user32.dll"")]"
file.WriteLine "    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);"
file.WriteLine "    [DllImport(""user32.dll"")]"
file.WriteLine "    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);"
file.WriteLine "    [StructLayout(LayoutKind.Sequential)]"
file.WriteLine "    public struct RECT {"
file.WriteLine "        public int Left;"
file.WriteLine "        public int Top;"
file.WriteLine "        public int Right;"
file.WriteLine "        public int Bottom;"
file.WriteLine "    }"
file.WriteLine "}"
file.WriteLine "'@"

file.WriteLine "[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')"
file.WriteLine "$monitors = [System.Windows.Forms.Screen]::AllScreens"
file.WriteLine "if ($monitors.Count -lt 2) { exit }"
file.WriteLine "$second = $monitors[1]" ' Change the 1 to a 2 to move discord to your third monitor :)
file.WriteLine "$wa = $second.WorkingArea"
file.WriteLine "$SW_MAXIMIZE = 3"

file.WriteLine "while ($true) {"
file.WriteLine "    $p = Get-Process Discord -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 -and $_.MainWindowTitle -and $_.MainWindowTitle -ne 'Discord Updater' }"
file.WriteLine "    if ($p) {"
file.WriteLine "        foreach ($proc in $p) {"
file.WriteLine "            $hwnd = $proc.MainWindowHandle"
file.WriteLine "            $rect = New-Object Win32+RECT"
file.WriteLine "            [Win32]::GetWindowRect($hwnd, [ref]$rect)"
file.WriteLine "            $w = $rect.Right - $rect.Left"
file.WriteLine "            $h = $rect.Bottom - $rect.Top"
file.WriteLine "            [Win32]::MoveWindow($hwnd, $wa.X, $wa.Y, $w, $h, $true)"
file.WriteLine "            sleep 0.5"
file.WriteLine "            [Win32]::ShowWindow($hwnd, $SW_MAXIMIZE)"
file.WriteLine "            exit"
file.WriteLine "        }"
file.WriteLine "    }"
file.WriteLine "    Start-Sleep -Seconds 1"
file.WriteLine "}"

file.Close

objShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & psFile & """", 0, False

