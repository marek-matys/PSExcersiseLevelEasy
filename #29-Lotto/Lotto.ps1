# Lotto

function check_input([int[]]$input_str,[int]$num_count){
    
   # Write-Host "input: $input_str" # uwaga - zmienna o tej samej nazwie nie moze wystepowac w innej czesci skryptu
    if($input_str.Length -ne $num_count -or ($input_str|Select-Object -Unique |measure).Count -ne $num_count){
        return $false
    }

    $num_array = @()

    foreach($in in $input_str){            
    
            if ($in -lt 1 -or $in -gt 49 ){
                return $false
            }
    }
    return $true
}

function generate_random_num_array([int]$numbers_count,[int]$min,[int]$max){
    $count = 0    
    
    $rand_num = @()

    while($count -lt $numbers_count){
            $random = Get-Random -Minimum $min -Maximum $max
            if($rand_num -notcontains $random){
                $rand_num += $random
                $count++
            }    
    }

    return $rand_num

}

$numbers_count = 6
$minimum = 1
$maximum = 50


$random_numbers = generate_random_num_array $numbers_count $minimum $maximum

$random_numbers_sorted = $random_numbers | Sort-Object 
$random_numbers_sorted

#$input = Read-Host "Podaj $numbers_count liczby oddzielone spacjami"

#$input_splitted = $input -split " "
#$input_splitted = $input_splitted | % { [int]::Parse($_) }


$number_of_drawings = 0

while($true){

    $hits_count = 0
    $input_automatic = generate_random_num_array $numbers_count $minimum $maximum
    $number_of_drawings++

    #if(check_input $input_automatic $numbers_count){
        foreach($num in $random_numbers_sorted) { # czy sorted szybsze niz unsorted ?
            if($input_automatic -contains $num){
                $hits_count++
            }   
        }

        if($hits_count -gt 4){
            Write-Host "Liczba hitow:$hits_count Numer losowania:$number_of_drawings"

        }

    #}else{
    #    Write-host "Bledne liczby lub ich za duzo"
    #}

}

