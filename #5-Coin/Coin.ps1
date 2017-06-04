
$how_many_toss = Read-Host "Ile rzutow"

$tails = 0 
$heads = 0

$time = Measure-Command{

for($i=0;$i -lt $how_many_toss;$i++){
    $result = Get-Random -Maximum 10 -Minimum 0
    
    if($result -lt 5){
        $tails +=1
    }else{
        $heads += 1
    }

}

}

Write-Host "Number of tails:$tails, number of heads:$heads, number of throws: $how_many_toss, time: $($time.milliseconds)"