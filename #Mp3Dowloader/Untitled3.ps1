$Code = {
    param ($init)
    $start = Get-Date
    (1..$init) | % { Start-Sleep -Seconds 1; $init +=1 }
    $stop = Get-Date
    Write-Output "Counted from $($init - 30) until $init in $($stop - $start)."
}

$jobs = @()
(10,20,30) | % { $jobs += Start-Job -ArgumentList $_ -ScriptBlock $Code }

#Wait-Job -Job $jobs #| Out-Null
#Receive-Job -Job $jobs

$jobsCompleteFlag = $jobs | ? State -NE "Completed"
#$myScreenPos = $Host.UI.RawUI.CursorPosition    

    while($jobsCompleteFlag -ne $null){
        Start-Sleep 1
        #cls
        $jobs #| Out-String
        $jobsCompleteFlag = $jobs | ? State -NE "Completed"
        #$Host.UI.RawUI.CursorPosition = $myScreenPos
    }




#My options

#dot sourcing fiunctions
#dot sorcing scripts as code 
#executing scripts with some invoke

#$invocation = (Get-Variable MyInvocation).Value

#$job = Start-Job -FilePath "C:\TEMP\Untitled2.ps1" -Name jjj