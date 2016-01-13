Param($btour,$etour)

$now = Get-Date

if($now -gt [string]$etour)
{ "According to the system clock your not schedule for work right now.";
  exit;    
}

$et = [datetime]($now.ToShortDateString() + " " + $etour)
$lenght=[datetime]$etour - [datetime]$btour #Total of minutes at work
$y = $et - $now
$x = $y.TotalSeconds
$MinText = "minutes"

while($x -gt 0) {
 $min = [int](([string]($x/60)).split('.')[0])
 if ($min -eq "1"){$MinText = "minute"}

 if ($min -eq "0") {
 $min = $null
 $MinText = "less than a minute"
 $Beep = [system.console]::Beep(2900,50)
 }

 $text = " " +"{0:00}" -f([Math]::Truncate($min/60)) + ":" + "{0:00}" -f(($min%60)) + ":" + "{0:00}" -f(($x % 60))
 $beep 
 Write-Progress "Time left remaining on the clock" -status $text -perc ($x/$length.TotalMinutes)
 start-sleep -s 1
 $x --
}
