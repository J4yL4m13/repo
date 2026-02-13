<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Take snapshots of multiple machines in vCenter.
Ideal if you are about to roll some updates out to a bunch of servers

.EXAMPLE

.OUTPUTS

.NOTES
Import-module -name VMware.PowerCLI
#>

##############
# Start Config
##############

$vcenter = "vcenter01.localdomain.lan"

$servers = @('server01', 'server02', 'server03')
$snapshotname = "some_name"
$snapshotdescription = "some_description"

##############
# End Config
##############

# Connect to vcenter
Connect-VIServer -server $vcenter

# Loop through servers and
foreach ($server in $servers) {
    get-vm $server | new-snapshot -Name $snapshotname -Description $snapshotdescription -Quiesce -Memory
}