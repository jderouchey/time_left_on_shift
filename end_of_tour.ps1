Param([datetime]$btour,[datetime]$etour)

If (-not($btour) -or -not($etour)){
exit
}

$now = Get-Date

If ($etour -lt $btour)
{
    If ($now -gt "00:00" -and $now -lt "12:00")
    {
        $btour=$btour.AddDays(-1)
    }
    Else
    {
        $etour = $etour.AddDays(1)
    }
 }   
Elseif ($now -gt $etour)
{ 
    "According to the system clock your not schedule for work right now.";
    exit;    
}

$lenght = $etour - $btour #Total of minutes at work
$x = $etour - $now


for ($a = $x.TotalSeconds; $a -gt 1; $a--) {
  $complete = $a / $lenght.TotalSeconds;
  $complete = "{0:P2}" -f $complete
  Write-Progress -Activity "Working..." -SecondsRemaining $a -CurrentOperation "$complete complete" -Status "Please wait."
  Start-Sleep 1
}
