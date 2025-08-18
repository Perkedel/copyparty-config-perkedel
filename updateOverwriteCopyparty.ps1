#!/bin/pwsh
# Download new copyparty SFX & overwrite the old one

$Wget = "wget"
$Download = "https://github.com/9001/copyparty/releases/latest/download/copyparty-sfx.py"

Invoke-Expression "$($Wget) $($Download) -N"