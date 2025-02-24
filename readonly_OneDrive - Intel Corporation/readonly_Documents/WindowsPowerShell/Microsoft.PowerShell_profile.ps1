#$Env:KOMOREBI_AHK_EXE = "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"
$Env:KOMOREBI_AHK_EXE = "C:\Users\shanneng\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe"
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-Alias v nvim
Set-Alias vi nvim
Invoke-Expression (&starship init powershell)
