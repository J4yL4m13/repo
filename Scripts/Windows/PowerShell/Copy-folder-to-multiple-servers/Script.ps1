<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Copy folder to remote servers using the admin share c$\temp.
Ideal if you are about to roll some updates out to a bunch of servers

.EXAMPLE

.OUTPUTS

.NOTES
#>

##############
# Start Config
##############

$servers = @('server01', 'server02', 'server03')
$localfoldertocopy = "C:\temp\test\"
$destination = "c$\temp\"

##############
# End Config
##############

foreach ($server in $servers) {
    Copy-Item -Recurse -Path $localfoldertocopy -Destination \\$server\$destination
}
