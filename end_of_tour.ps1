
# If you have trouble running the script the fix is to run Set-ExecutionPolicy and change the Execution Policy setting.
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Param([datetime]$btour,[datetime]$etour)

if (-not($btour) -or -not($etour)){
exit
}

$now = Get-Date

If ($etour -lt $btour)
 {
    If ($now -gt "00:00" -and $now -lt "12:00")
     {
        $btour=$btour.AddDays(-1)
     }
    else
     {
        if($btour -gt $now){exit;}
        $etour = $etour.AddDays(1)
     }
 }
elseif ($now -gt $etour)
  { 
    exit;  
  }
elseif ($btour -gt $now)
  {
    exit;
  }
 
$lenght = $etour - $btour #Total of minutes at work
$x = $etour - $now

for ($a = $x.TotalSeconds; $a -gt 1; $a--) {
  $complete = $a / $lenght.TotalSeconds;
  $complete = "{0:P2}" -f $complete
  Write-Progress -Activity "Working..." -SecondsRemaining $a -CurrentOperation "$complete remaining" -Status "Please wait."
  Start-Sleep 1
}
