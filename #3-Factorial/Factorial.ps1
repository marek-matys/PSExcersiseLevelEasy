
$number = Read-Host "Podaj liczbe"

#$output = 1

#recursive measured 

function factorial_rec([int]$numer_input)
{
    
    if($numer_input -gt 1) {                
        
        $output = $numer_input * ( factorial_rec ($numer_input - 1) )
    }
    return $output
}



$time_recursive =  Measure-Command{

    $output_recursive =+ ( factorial_rec $number)

}

$time_iterative =  Measure-Command{

#iterative

    $output_iterative = 1

    For($i=1;$i -le $number;$i++){
        $output_iterative *= $i
    }    
}

Write-Host "Out recursive: $output_recursive time:$($time_recursive.Ticks)"
Write-Host "Out iterative: $output_iterative time:$($time_iterative.Ticks)"




