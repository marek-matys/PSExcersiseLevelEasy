$log_error_application = Get-EventLog -EntryType Error -After ( (Get-Date).AddDays(-7)) -LogName Application
$log_warning_application = Get-EventLog -EntryType Warning -After ( (Get-Date).AddDays(-7)) -LogName Application

$log_error_system = Get-EventLog -EntryType Error -After ( (Get-Date).AddDays(-7)) -LogName System 
$log_error_system_gr = $log_error_system | Group-Object -Property source

$log_warning_system = Get-EventLog -EntryType Warning -After ( (Get-Date).AddDays(-7)) -LogName System 

$log_warning_system_sorted = $log_warning_system | select timeGenerated,source,instanceID,Message  | Sort-Object source,timeGenerated -Descending 
$log_warning_system_grouped = $log_warning_system | Group-Object -Property source | select Count,Name


$log_warning_system_grouped_html = ($log_warning_system_grouped | ConvertTo-Html -Fragment) -replace "<table>","<table class=`"warn_summary`">"
$log_warning_system_sorted_html = ($log_warning_system_sorted | ConvertTo-Html -Fragment) -replace "<table>","<table class=`"warn_details`">"




Summary all servers

Detalis servers 


Summary by server

Details by server

Top 10 error ( by source )

Top 10 warnings ( by source )

Top 10 Error ( by Meassage )

Top 10 Warnings ( by Message )