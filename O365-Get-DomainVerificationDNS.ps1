#Retrieve Required DNS Entries for O365 Domain Validation

#First Connect to the tenant. Prompt will popup for user credentials.
Connect-MsolService

#Retrieve List of Doamins to Validate from CSV file previously used to add domains to O365 Tenant
$DomainsToValidate = import-csv Exchange_Accepted_Domains.csv

#Loop Through list of domains and Build CSV output of required DNS entries.

Foreach ($Domain in $DomainsToValidate)
{
	Get-MsolDomainVerificationDns -DomainName $Domain.DomainName | select label,ttl | export-csv -Path ".\DomainVerificationDns.csv" -append
}