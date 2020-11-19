$runStart0 = Get-itemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$runStart = $runStart0.psObject.properties | Where-Object{$_.name -notlike 'PS*'} | Select-Object value
$runStart = $runStart.ForEach({$_.value})
$a = 0
while($true){
    $a ++
    write-host -ForegroundColor blue "scan #"$a ", @" (get-date) ">>>"
    Start-Sleep -Seconds 60
    $tempRun0 = Get-itemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
    $tempRun = $tempRun0.psObject.properties | Where-Object{$_.name -notlike 'PS*'} | Select-Object value
    $tempRun = $tempRun.ForEach({$_.value})
    
    $alert = Compare-Object -ReferenceObject $runStart -DifferenceObject $tempRun -PassThru

    if($alert){
        write-host -ForegroundColor red "Alert! <<<>>> Alert!" (get-date) "Alert! <<<>>> Alert!" 
        Write-host "Summary:"
        Compare-Object -ReferenceObject $runStart -DifferenceObject $tempRun
        $runStart = $tempRun
    }
    else{
        write-host -ForegroundColor green "<<<>>> Clean <<<>>>"
    }
}
