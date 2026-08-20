#!/bin/pwsh
# Download new AdNauseam Chromium Extension ZIP & overwrite the old one

$Wget = "wget"
$7zip = "7z"
$Download = "https://github.com/dhowe/AdNauseam/releases/latest/download/adnauseam.chromium.zip"

Invoke-Expression "$($Wget) $($Download) -N"

## then extract!

Invoke-Expression "$($7zip) x adnauseam.chromium.zip"