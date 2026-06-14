[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::InvariantCulture
$j = Get-Content -Raw -Encoding UTF8 son_test.json | ConvertFrom-Json
$idle = [math]::Round($j.ping.latency, 2)
$jit  = [math]::Round($j.ping.jitter, 2)
$dl   = [math]::Round($j.download.bandwidth * 8 / 1000000, 2)
$dll  = [math]::Round($j.download.latency.iqm, 2)
$ul   = [math]::Round($j.upload.bandwidth * 8 / 1000000, 2)
$ull  = [math]::Round($j.upload.latency.iqm, 2)
$pl   = $j.packetLoss
if ($null -eq $pl) { $pl = 0 }
$srv  = $j.server.name + ' ' + $j.server.location
$isp  = $j.isp
$url  = $j.result.url
Write-Output ("{0}#{1}#{2}#{3}#{4}#{5}#{6}#{7}#{8}#{9}" -f $idle,$jit,$dl,$dll,$ul,$ull,$pl,$srv,$isp,$url)