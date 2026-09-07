#!/bin/pwsh
# Download new copyparty SFX & overwrite the old one

# https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.6
# https://netwrix.com/en/resources/blog/powershell-for-while-loop/

$Wget = "wget"
# $Download = "https://github.com/9001/copyparty/releases/latest/download/copyparty-sfx.py"
$Downloads = @(
    @('kameloso', 'https://github.com/steinuil/kameloso/releases/latest/download/kameloso-x86_64-pc-windows-gnu.zip', 'kameloso-x86_64-pc-windows-gnu.zip'),
    @('kameloso', 'https://github.com/steinuil/kameloso/releases/latest/download/kameloso-x86_64-unknown-linux-gnu.zip', 'kameloso-x86_64-unknown-linux-gnu.zip')
)

# Invoke-Expression "$($Wget) $($Download) -N"

foreach ($dl in $Downloads) {
    Invoke-Expression "$(Wget) $(dl[1]) -N -O '$(dl[0])\$(dl[2])'"
}