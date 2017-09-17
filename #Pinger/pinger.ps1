$success = 1
$failure = 0

$ping_time = 0
$total_time = 0
$sample_time = 0

$avg_total_time = 0
$avg_sample_time = 0

$sample_size = 100

$time_array= new-object int[] $sample_size

while($true){
    $percentage =  (($success / ($success+$failure))*100)
    Write-Progress -Activity "Testing connection ..." -PercentComplete $percentage -Status ( "Success: {0} || Failure: {1} || % success: {2:f2} || Avg.response: {3:f2} || Avg.response sample: {4:f2}" -f $success,$failure,$percentage,$avg_total_time,$avg_sample_time)
    try{
     $out = Test-Connection 8.8.8.8 -Count 1 -Delay 1 -ErrorAction Stop # Catch is only invoked on Terminating Errors
     $success++

     $sum = ($success+$failure)

     $ping_time = ($out.ResponseTime | Measure-Object -Average).Average
     $total_time += $ping_time
     $avg_total_time = $total_time / $sum         
     
     $time_array[$sum % $sample_size] = $ping_time
     
     if($sum -lt $sample_size){
        $sample_time += $ping_time
        $avg_sample_time  = $sample_time / $sum
     }else{
        $sample_time += $ping_time
        $index = ($sum + 1) % $sample_size
        $avg_sample_time = ($sample_time - $time_array[$index]) / $sample_size
        $sample_time -= $time_array[$index]
     }
     
    }catch [System.Net.NetworkInformation.PingException] {
     $failure++
    }
}