# Path to the CSV file
$csvPath = "C:\path\to\users.csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Loop through each user and create the AD user
foreach ($user in $users) {
    $username = $user.username
    $firstname = $user.firstname
    $lastname = $user.lastname
    $password = (ConvertTo-SecureString $user.password -AsPlainText -Force)
    $email = $user.email
    $userPrincipalName = "$username@yourdomain.com"

    # Create the user
    New-ADUser `
        -Name "$firstname $lastname" `
        -GivenName $firstname `
        -Surname $lastname `
        -SamAccountName $username `
        -UserPrincipalName $userPrincipalName `
        -EmailAddress $email `
        -AccountPassword $password `
        -Enabled $true `
        -PasswordNeverExpires $true `
        -ChangePasswordAtLogon $false
}
