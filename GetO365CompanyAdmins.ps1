#Connect to Office 365 tenant - You will be prompted for credentials)
connect-msolservice

#Get a list of comapny administrators
$role = get-msolrole -RoleName "Company Administrator"

get-msolRoleMember -RoleObjectID $role.ObjectId | select DisplayName, isLicensed | export-csv -path ".\O365ComapnyAdmins.csv"