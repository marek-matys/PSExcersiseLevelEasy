function check_binary([string]$input_str){
    #Write-Host $input_str
    foreach($char in $input_str.ToCharArray()){
        #Write-Host "char $char"
        if($char -notin ('0','1') ){
            return $false
        }        
    }
    return $true
}

function check_decimal([string]$input_str){
    Write-Host $input_str
    foreach($char in $input_str.ToCharArray()){
        Write-Host "char $char"
        if($char -notin ('0','1','2','3','4','5','6','7','8','9') ){
            return $false
        }        
    }
    return $true
}

function check_octal([string]$input_str){
    #Write-Host $input_str
    foreach($char in $input_str.ToCharArray()){
        #Write-Host "char $char"
        if($char -notin ('0','1','2','3','4','5','6','7') ){
            return $false
        }        
    }
    return $true
}

function check_hex([string]$input_str){
    #Write-Host $input_str
    foreach($char in $input_str.ToCharArray()){
        #Write-Host "char $char"
        if($char -inotin ('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f') ){
            return $false
        }        
    }
    return $true
}


$menu_str = @"
1. Binary to Decimal
2. Binary to Hex
3. Binary to Octal
4. Decimal to Hex
5. Decimal to Binary
6. Decimal to Octal
7. Octal to Binary
8. Octal to Hex
9. Octal to Decimal
10. Hex to Binary
11. Hex to Decimal
12. Hex to Octal
"@

$menu_str
$conversion_choice = Read-Host "Wybierz opcje"
$number = Read-Host "Podaj liczbe"


[int]$sum = 0

switch ($conversion_choice)
{
    
    '1' {   
            [int]$conv = 0    
            if(check_binary $number){
                Write-host "Binary"
                for($i=0;$i=$number.Length,$i++){
                    [int]::TryParse($number[$i],[ref] $conv)
                    $sum +=  $conv * [Math]::Pow(2,($number.Length - $i))
                }
                
            }else{
                Write-Host "Not a binary number"
            }
        }    
    '2' {
            Write-Host "asd2"
        }

    '4' {
            if(check_decimal $number){
                Write-host "Decimal"
            }else{
                Write-Host "Not a decimal number"
            }
        }
     '7' {
            if(check_octal $number){
                Write-host "Octal"
            }else{
                Write-Host "Not a octal number"
            }
        }
     '10' {
            if(check_hex $number){
                Write-host "Hex"
            }else{
                Write-Host "Not a hex number"
            }
        }
    Default {
        Write-Host "GFY"
        break
    }
}

Write-Host "Sum $sum"


