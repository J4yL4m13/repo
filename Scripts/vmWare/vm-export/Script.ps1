<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION

.EXAMPLE

.OUTPUTS

.NOTES
#>

##############
# Start Config
##############
$vcenterarry = @('vcenter01.localdomain.lan')
$exportpath = "c:\temp\"
$filename = "vm-export.csv"
##############
# End Config
##############

# Loop through vCenters in array
foreach ($v in $vcenterarry) {
    $vmout = Get-VM | Select Name, Notes, @{N = "Full OS"; E = { $_.Guest.OSFullName } }, NumCpu, CoresPerSocket, MemoryGB, VMHost, HardwareVersion, Folder, PowerState, @{N = "VMX"; E = { $_.Extensiondata.Summary.Config.VmPathName } } | Export-Csv -path $exportpath$filename".csv" -Append
}