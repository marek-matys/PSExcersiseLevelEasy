$earth_rad = 6371

$cities = @{"Warsaw"="21.012229;52.229676";
            "Cracov"="19.9449799;50.0646501"
            "Bialystok" = "23.168840;53.132489"
            } #Longitudde, Latitude

$input1 = Read-Host "City1"
$input2 = Read-Host "City2"
$input3 = Read-Host "Convert to miles ? [y/n]"

# convert lat to rad

$lat1 = ($cities.($input1) -split ";")[1]
$lat2 = ($cities.($input2) -split ";")[1]

$lon1 = ($cities.($input1) -split ";")[0]
$lon2 = ($cities.($input2) -split ";")[0]

$fi1 = [Math]::PI/180 * $lat1
$fi2 = [Math]::PI/180 * $lat2

$delta_fi = [Math]::Pi/180 * ($lat2 - $lat1)
$delta_lambda = [Math]::PI/180 * ($lon2-$lon1)

$a = [Math]::Sin($delta_fi/2) * [Math]::Sin($delta_fi/2) +
     [Math]::Cos($fi1) * [Math]::Cos($fi2) *
     [Math]::Sin($delta_lambda/2) * [Math]::Sin($delta_lambda/2)

$c = 2 * [Math]::Atan2([Math]::Sqrt($a),[Math]::Sqrt(1-$a))

$d = $earth_rad * $c

$unit_str = "kilometers"

if($input3 -eq "y"){
    $d = $d * 0.62137
    $unit_str = "miles"        
}

$d = [Math]::Round($d,2)

Write-Host "The distance is: $d $unit_str"
