function create_system_charArray([int]$input_system){
    
    $out = @()

    for($i=0;$i -lt $input_system;$i++){
            if($i -lt 10){
                $out += [char](48 + $i)
            }
            else{
                $out += [char](65-10+$i)
            }

    }
    return $out

}

function check_number([string]$input_str,[char[]]$systemCharArray){
        
    foreach($char in $input_str.ToCharArray()){
        if($char -inotin $systemCharArray ){
            return $false
        }        
    }
    return $true
}


$system1 = Read-Host "Podaj system zrodlowy (gorne ograniczenie)"

$number = Read-Host "Podaj liczbe w systemie zrodlowym"

$number = $number.ToUpper()

$systemInCharArray = create_system_charArray $system1

if(check_number $number $systemInCharArray){
    #Write-Host "OK liczba"
}else{
    Write-Host "Liczba z poza systemu"
    break
}

$system2 = Read-Host "Podaj system docelowy (gorne ograniczenie)"

$system2 = [int]$system2
 
$systemOutCharArray = create_system_charArray $system2


[int]$sum = 0

[int]$pow = 0

[string]$str_sum = ''

[bool]$error_flag = $false

# convert system 1 to decimal

for($i = 0;$i -lt $number.Length;$i++){
    $index = $systemInCharArray.IndexOf([char]"$($number[$i])")
    $sum += $index * [Math]::Pow($system1,($number.Length - $i -1))
}

# convert to system2
   
while($sum / [Math]::Pow($system2,$pow) -ge $system2){
     $pow ++                    
}

for($i = $pow;$i -ge 0; $i--){
     [double]$tmp = ($sum / [Math]::Pow($system2,$i) ) % $system2

     $tmp = [Math]::Floor($tmp)
                
     $str_sum += ($systemOutCharArray[[int]$tmp]).ToString()     
}                

if(-not $error_flag){

    Write-Host "Sum $str_sum"
}


