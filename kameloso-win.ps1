# Run Kameloso right away for it this
# (JOELwindows7)

$anKameloso = ".\kameloso.exe"
$anArgs = "--serve-dir=.\Landing\custom\kameloso\public"

Invoke-Expression ".$($anKameloso) $($anArgs)"