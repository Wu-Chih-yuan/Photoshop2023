<#
阻止Photoshop的出站连接
用PowerShell管理员运行
把下面变量root的值设置为你实际安装Photoshop的目录
#>

$root = "D:\Photoshop安装目录"

Get-ChildItem -LiteralPath $root -Recurse -Filter *.exe -File | ForEach-Object {
    New-NetFirewallRule `
        -DisplayName "PS-NO-NET-OUT-$($_.FullName)" `
        -Direction Outbound `
        -Program $_.FullName `
        -Action Block `
        -Profile Any `
        -ErrorAction SilentlyContinue

    New-NetFirewallRule `
        -DisplayName "PS-NO-NET-IN-$($_.FullName)" `
        -Direction Inbound `
        -Program $_.FullName `
        -Action Block `
        -Profile Any `
        -ErrorAction SilentlyContinue
}