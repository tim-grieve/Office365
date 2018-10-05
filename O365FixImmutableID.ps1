#Fix missing immutableID where Office 365 account should be associated with a corresponding AD account in a federated domain.

#Prepare Active Directory Commands
import-module activedirectory

#Connect to O365
connect-msolservice

#Get Guid of Target user
$userUPN = Read-Host "Enter UPN of AD user to Fix immutableID"
$guid = [guid]((Get-ADUser -LdapFilter "(userPrincipalName=$userUPN)").objectGuid)

#Convert Guid to immutableId
$immutableId = [System.Convert]::ToBase64String($guid.ToByteArray())	

#Write immutableId back to O365 user objectGuid
Get-MsolUser -UserPrincipalName $userUPN | Set-MsolUser -ImmutableId $immutableId