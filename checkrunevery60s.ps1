$runStart = Get-itemProperty -path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HKCU:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run, "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run", HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce, HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx, HKLM:\System\CurrentControlSet\Services, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction Ignore
$runStart = $runStart.psObject.properties | Where-Object{$_.name -notlike 'PS*'} | Select-Object value
$runStart = $runStart.ForEach({$_.value})
$a = 0
while($true){
    $a ++
    write-host -ForegroundColor blue "scan #"$a ", @" (get-date) ">>>"
    $tempRun = Get-itemProperty -path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HKCU:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run, "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run", HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServices, HKCU:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce, HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx, HKLM:\System\CurrentControlSet\Services, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices, HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce -ErrorAction Ignore
    $tempRun = $tempRun.psObject.properties | Where-Object{$_.name -notlike 'PS*'} | Select-Object value
    $tempRun = $tempRun.ForEach({$_.value})
    
    $alert = Compare-Object -ReferenceObject $runStart -DifferenceObject $tempRun -PassThru

    if($alert){
        write-host -ForegroundColor red "Alert! <<<>>> Alert!" (get-date) "Alert! <<<>>> Alert!" 
        Write-host "Summary:" $alert
        $runStart = $tempRun
    }
    else{
        write-host -ForegroundColor green "<<<>>> Clean <<<>>>"
    }
    Start-Sleep -Seconds 5
}
