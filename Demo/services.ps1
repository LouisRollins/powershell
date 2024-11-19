# Test Sync
$computers = Get-ADComputer -Filter "OperatingSystem -eq 'Windows Server 2019 Datacenter Evaluation'" -Properties OperatingSystem,IPv4Address,lastLogonDate 

ForEach ($computer in $computers){
    $os = $computer.OperatingSystem
    $ip = $computer.IPv4Address
    $lastLogon = $computer.lastLogonDate
    $hostname = $computer.DNSHostName

    write-host $hostname "is running" $os "with an IP address of" $ip "and was last logged in at" $lastLogon

}

#Create a new AD user, prompting the script runner for the minimum input needed to create the user

$first = Read-Host "Provide a first name"
$last = Read-Host "Provide a last name"
$name = $first+" "+$last
$password = Read-Host -AsSecureString "Set a password"
$department = Read-Host "Provide a department"
New-ADUser -givenname $first -surname $last -Name $name -AccountPassword $password -samaccountname "$first.$last" -Department $department -Path "OU=$department,DC=Adatum,DC=com" -Enabled $true

Get-ADUser -filter "name -like 'apple*'" -property * 
Remove-ADUser -identity "Apple.Orange"

#backup an important folder and check the time difference between now and the last modified time

$important= "C:\Users\Administrator.ADATUM\Desktop\IMPORTANT"
$backupFolder= "E:\backup"

$checkTime=(gci $important).LastWriteTime

ForEach($i in $checkTime){
   $now = Get-Date
   $compareTime = New-TimeSpan -Start $i -End $now
   if ($compareTime.TotalMinutes -gt 1){
        copy-item -path $important -destination $backupFolder -force -recurse
        }
 
}