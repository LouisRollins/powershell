#Get computers running a specific OS, then show me what OS they are running, their IPv4 address, and their last logon time.

$computers = Get-ADComputer -Filter "OperatingSystem -eq 'Windows Server 2019 Datacenter Evaluation'" -Properties OperatingSystem,IPv4Address,lastLogonDate 

ForEach ($computer in $computers){
    $os = $computer.OperatingSystem
    $ip = $computer.IPv4Address
    $lastLogon = $computer.lastLogonDate
    $hostname = $computer.DNSHostName

    write-host $hostname "is running" $os "with an IP address of" $ip "and was last logged in at" $lastLogon

}

#Create a new AD user, prompting the script runner for the minimum input needed to create the user.

$first = Read-Host "Provide a first name"
$last = Read-Host "Provide a last name"
$name = $first+" "+$last
$password = Read-Host -AsSecureString "Set a password"
$department = Read-Host "Provide a department"
New-ADUser -givenname $first -surname $last -Name $name -AccountPassword $password -samaccountname "$first.$last" -Department $department -Path "OU=$department,DC=Adatum,DC=com" -Enabled $true

Get-ADUser -filter "name -like 'apple*'" -property * 
Remove-ADUser -identity "Apple.Orange"

#Backup an important folder if there is a difference of one minute or greater between the LastWriteTime of the source file and the backup file.
$important= "C:\Users\Administrator.ADATUM\Desktop\IMPORTANT"
$backupFolder= "E:\backup"

$checkTime=(gci $important).LastWriteTime

ForEach($i in $checkTime){
   $backupTime = (gci $backupFolder).LastWriteTime
   $compareTime = New-TimeSpan -Start $i -End $backuptime
   if ($compareTime.TotalMinutes -gt 1){
        copy-item -path $important -destination $backupFolder -force -recurse
        }
 
}


#Scrape a website for a specific list
$url = "https://swudb.com/deck/view/yfLSWFLbnuYVP?handler=TextFile"
$response = Invoke-WebRequest $url
$data = $response.Content
write-output $data

#Scrape a website for a specific list and capture it as JSON, then copy the output to clipboard
$url = "https://swudb.com/deck/view/yfLSWFLbnuYVP?handler=JSONFile"
$response = Invoke-WebRequest $url
$data = $response.Content
$data | clip

#Grabbing a random leader from the leader dropdown on the search page....
$url= "https://swudb.com/decks/search"
$response = Invoke-WebRequest $url
$dropdown = $response.ParsedHtml.getElementById("SearchLeaderID").GetElementsByTagName("option") | select-object
$modifiedDropdown = $dropdown[1..($dropdown.Length-1)]
$randomSelection = Get-Random -InputObject $modifiedDropdown
Write-Output $randomSelection.text
$search = $response.ParsedHtml.getElementsByTagName("input") | Where-Object {$_.defaultValue -eq 'Search'}
$search.click()
