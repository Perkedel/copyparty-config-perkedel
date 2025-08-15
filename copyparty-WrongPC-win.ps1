#!/usr/bin/env pwsh
# Quick config to run copyparty for specific server
# (JOELwindows7)

$Python = "python"
$Copyparty = "./copyparty-sfx.py"
$SelectConf = "./conf/conf-WrongPC-Win.conf"

Invoke-Expression "$($Python) $($Copyparty) -c $($SelectConf)"