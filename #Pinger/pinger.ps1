$success = 1
$failure = 0
$avg_time = 0
$avg_time_total = 0

while($true){
    $percentage =  (($success / ($success+$failure))*100)  
    Write-Progress -Activity "Testing connection ..." -PercentComplete $percentage -Status "Success:$success, Failure:$failure, Percantege:$percentage, Avg.response: $avg_time_total"
    try{          
     $out = Test-Connection 8.8.8.8 -Count 2 -Delay 1 -ErrorAction Stop # Catch is only invoked on Terminating Errors
     $success++
     $avg_time += ($out.ResponseTime | Measure-Object -Average).Average
     $avg_time_total = $avg_time / ($success+$failure)
    }catch [System.Net.NetworkInformation.PingException] {
     $failure++          
    }
}