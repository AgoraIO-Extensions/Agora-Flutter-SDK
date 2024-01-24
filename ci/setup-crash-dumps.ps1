# setup-crash-dumps.ps1
$dumpFolder = ".\CrashDumps"
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps"

# 创建转储文件夹
if (-not (Test-Path -Path $dumpFolder)) {
    New-Item -Path $dumpFolder -ItemType Directory
}

# 设置注册表以启用崩溃转储
New-Item -Path $registryPath -Force
New-ItemProperty -Path $registryPath -Name "DumpFolder" -Value (Resolve-Path $dumpFolder) -PropertyType String -Force
New-ItemProperty -Path $registryPath -Name "DumpCount" -Value 10 -PropertyType DWord -Force
New-ItemProperty -Path $registryPath -Name "DumpType" -Value 2 -PropertyType DWord -Force

Write-Host "Crash dump settings configured successfully."
