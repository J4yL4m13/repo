<#
.SYNOPSIS
Created by James Lambert
www.roonics.com

.DESCRIPTION

.EXAMPLE

.OUTPUTS

.NOTES

#>

cls
$servers = Get-Content computers.txt

foreach($server in $servers)

{

 $nics = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $server -ErrorAction Inquire | Where{$_.IPEnabled -eq "TRUE"}

	foreach($nic in $nics)
	{
	Write-Host $server "-" $nic.IPAddress "-" $nic.FullDNSRegistrationEnabled
	}
}