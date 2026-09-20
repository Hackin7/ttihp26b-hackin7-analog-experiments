$log = 'C:\openprobe\proof.raw.log'
$tmp = 'C:\openprobe\osc_meas_surface.awk'
Set-Content -LiteralPath $tmp -Encoding ASCII -Value @'
/osc_|period|freq|SG13G2 REAL-GATE|OSC PROOF|osc_period|osc_freq/ {
  if ($0 !~ /osdi|redefin|osdi\, can|redefin\, can|redefin/) print $0
}
'@
$awkOut = & awk -f $tmp "$log" 2>$null
foreach ($line in $awkOut) {
  if ($line -match 'osc_|osc|period|freq|SG13G2|REAL-GATE|PROOF') {
    $line.Trim()
  }
}
