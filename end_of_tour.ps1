$now = Get-Date
$et = [datetime]($now.ToShortDateString() + " 09:30 PM")
$nts = New-TimeSpan -Start $now -End $et

$h = [int]$nts.Hours
$m = [int]$nts.Minutes
$s = [int]$nts.Seconds

$x = ($h*3600)+($m*60)+$s
$length = 306 

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
 Write-Progress "Time left remaining on the clock" -status $text -perc ($x/$length)
 start-sleep -s 1
 $x--
}
