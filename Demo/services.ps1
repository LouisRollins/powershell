# Test Sync
$computers = Get-ADComputer -Filter "OperatingSystem -eq 'Windows Server 2019 Datacenter Evaluation'" -Properties OperatingSystem,IPv4Address,lastLogonDate 

ForEach ($computer in $computers){
    $os = $computer.OperatingSystem
    $ip = $computer.IPv4Address
    $lastLogon = $computer.lastLogonDate
    $hostname = $computer.DNSHostName

    write-host $hostname "is running" $os "with an IP address of" $ip "and was last logged in at" $lastLogon

}

