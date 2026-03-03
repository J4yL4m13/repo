<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Script connects to Active Directory and exports a list of all servers
Required: Import-ActiveDirectory

.EXAMPLE

.OUTPUTS

.NOTES

#>

##############
# Start Config
##############

##############
# End Config
##############

Get-ADComputer -Filter "OperatingSystem -like '*Server*'" -Properties OperatingSystem | Select-Object Name, OperatingSystem | Export-Csv "AD_Servers.csv" -NoTypeInformation