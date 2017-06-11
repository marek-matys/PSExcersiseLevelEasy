$binary_conv = @{'1'=1;'0'=0}

$bin_to_hex_conv = @{'0000'='0';'0001'='1';'0010'='2';'0011'='3';'0100'='4';'0101'='5';'0110'='6';'0111'='7';'1000'='8';'1001'='9';
                    '1010'='A';'1011'='B';'1100'='C';'1101'='D';'1110'='E';'1111'='F'}

$octal_conv = @{'7'=7;'6'=6;'5'=5;'4'=4;'3'=3;'2'=2;'1'=1;'0'=0}

$octal_to_hex_conv = @{}

$deci_to_hex = @{0='0';1='1';2='2';3='3';4='4';5='5';6='6';7='7';8='8';9='9';10='a';11='b';12='c';13='d';14='e';15='f' }

$deci_to_bin = @{0='0';1='1'}

$deci_to_oct = @{0='0';1='1';2='2';3='3';4='4';5='5';6='6';7='7'}


$hex_conv = @{'0'=0;'1'=1;'2'=2;'3'=3;'4'=4;'5'=5;'6'=6;'7'=7;'8'=8;'9'=9;'a'=10;'b'=11;'c'=12;'d'=13;'e'=14;'f'=15}

$hex_to_bin_conv = @{'0'='0000';'1'='0001';'2'='0010';'3'='0011';'4'='0100';'5'='0101';'6'='0110';'7'='0111';'8'='1000';'9'='1001';'a'='1010';'b'='1011';'c'='1100';'d'='1101';'e'='1110';'f'='1111'}

$hex_to_oct_conv = @{'0'='00';'1'='01';'2'='02';'3'='03';'4'='04';'5'='05';'6'='06';'7'='07';'8'='10';'9'='11';'a'='12';'b'='13';'c'='14';'d'='15';'e'='16';'f'='17'}

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
    #Write-Host $input_str
    foreach($char in $input_str.ToCharArray()){
        #Write-Host "char $char"
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

[string]$str_sum = ''

[bool]$error_flag = $false

[int]$conv = 0

switch ($conversion_choice)
{
    
    '1' {   
            
            if(check_binary $number){
                #Write-host "Binary"
                for($i = 0;$i -lt $number.Length;$i++){
                    
                    $sum += [int]$binary_conv."$($number[$i])" * [Math]::Pow(2,($number.Length - $i -1))
                                                            
                }

                $str_sum = [string]$sum
                
            }else{
                Write-Host "Not a binary number"
                $error_flag = $true
            }
        }    
    '2' { # nie bangla 
            if(check_binary $number){                
                for($i = $number.Length;$i -gt 0;$i=$i-4){
                Write-Host "i = $i; number = $number "
                                                                                                         
                    $sum += [int]$binary_conv."$($number[$i])" * [Math]::Pow(2,($number.Length - $i -1)) 

                }
                $sum
                $str_sum = [string]$sum
                
            }else{
                Write-Host "Not a binary number"
                $error_flag = $true
            }
            
        }
    '3' { # nie bangla 
            if(check_binary $number){                
                for($i = $number.Length;$i -gt 0;$i=$i-4){
                    
                    $number.Substring($i-4,4)                    
                    
                    $sum += [int]$binary_conv."$($number[$i])" * [Math]::Pow(2,($number.Length - $i -1)) 
                }

                $str_sum = [string]$sum
                
            }else{
                Write-Host "Not a binary number"
                $error_flag = $true
            }
            
        }
    '4' {  # jest ok 
            if(check_decimal $number){
                Write-host "Decimal to hex"                

                $pow = 0

                while($number / [Math]::Pow(16,$pow) -ge 16){
                    $pow ++                    
                }

                #Write-Host $pow

                for($i = $pow;$i -ge 0; $i--){
                     $tmp = ($number / [Math]::Pow(16,$i) ) % 16
                     
                     $tmp = [Math]::Floor($tmp)
                     
                     $str_sum += $deci_to_hex.$([int]$tmp)
                     
                     
                     
                }                

            }else{
                Write-Host "Not a decimal number"
                $error_flag = $true
            }
        }
    '5' { # jest ok
            if(check_decimal $number){
                Write-host "Decimal to binary"                

                $pow = 0

                while($number / [Math]::Pow(2,$pow) -ge 2){
                    $pow ++                    
                }

                #Write-Host $pow

                for($i = $pow;$i -ge 0; $i--){
                     $tmp = ($number / [Math]::Pow(2,$i) ) % 2
                     #Write-Host "i = $i; tmp = $tmp"
                     
                     $tmp = [Math]::Floor($tmp)

                     #Write-Host "i = $i; tmp = $tmp"
                     
                     $str_sum += $deci_to_bin.$([int]$tmp)                                        
                     
                }                

            }else{
                Write-Host "Not a decimal number"
                $error_flag = $true
            }
        
        }
    '6' {
            if(check_decimal $number){
                Write-host "Decimal to binary"                

                $pow = 0

                while($number / [Math]::Pow(8,$pow) -ge 8){
                    $pow ++                    
                }

                #Write-Host $pow

                for($i = $pow;$i -ge 0; $i--){
                     $tmp = ($number / [Math]::Pow(8,$i) ) % 8
                     #Write-Host "i = $i; tmp = $tmp"
                     
                     $tmp = [Math]::Floor($tmp)

                     #Write-Host "i = $i; tmp = $tmp"
                     
                     $str_sum += $deci_to_oct.$([int]$tmp)                                        
                     
                }                

            }else{
                Write-Host "Not a decimal number"
                $error_flag = $true
            }
        }
    '9' {
            if(check_octal $number){
                
                for($i = 0;$i -lt $number.Length;$i++){
                    
                    $sum += [int]$octal_conv."$($number[$i])" * [Math]::Pow(8,($number.Length - $i -1))                                                           
                }
                
            }else{
                Write-Host "Not a ocatal number"
                $error_flag = $true
            }
         }
           
     '11' {
            if(check_hex $number){
                
                for($i = 0;$i -lt $number.Length;$i++){
                    
                    $sum += [int]$hex_conv."$($number[$i])" * [Math]::Pow(16,($number.Length - $i -1))                                                           
                }

                $str_sum = [string]$sum
                
            }else{
                Write-Host "Not a hex number"
                $error_flag = $true
            }
        }
    Default {
        Write-Host "GFY"
        break
    }
}

if(-not $error_flag){

    Write-Host "Sum $str_sum"
}


