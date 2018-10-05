#Find all Office365 accounts that don't have an associated AD account in a federated domain.
#Extract Guid of each AD account and apply it to the correct Office 365 account. 

#Prepare Active Directory Commands
import-module activedirectory

#Initialise Variables
$Domain = "domainname.com"

#Connect to O365
connect-msolservice

#Get list of users without immutableID
$userUPN = get-msoluser -DomainName $Domain | select userprincipalname,immutableid | where {$_.immutableid -eq $null}


#Loop through list of users 
#Retrieve Guid and convert to immutableID
#Set O365 user with ImmutableID
Foreach ($UPN in $userUPN)
{
	$user = $UPN.UserPrincipalName
	$guid = [guid]((Get-ADUser -LdapFilter "(userPrincipalName=$user)").objectGuid)

	#Convert Guid to immutableId
	$immutableId = [System.Convert]::ToBase64String($guid.ToByteArray())	

	#Write immutableId back to O365 user objectGuid
	Get-MsolUser -UserPrincipalName $User | Set-MsolUser -ImmutableId $immutableId
}