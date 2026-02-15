<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Tag-a-tron 9000

This script will loop through all vCenters in the vCenter array then all datacenters found then based on the vm name apply the correct tags.

"Company"
"OS"

The company value will depend on the name of the vm but, you can set their value in the config area if no match is found it will set
the company to "NONE SET" again this can be changed in the config area.

The OS value is determined by reading the guest os field in vCenter, if it starts "Microsoft" then the value will be "Windows" otherwise it will be "Linux".

.EXAMPLE
If you are planning on running this via a pipeline make sure to edit and uncomment the correct connect line.

.OUTPUTS

.NOTES
#>

##############
# Start Config
##############

# vCenter address
$vcenterarry = @('vcenter.home.lan')

# Company tag values
$category = "Company"
$Company1 = "Company1"
$Company2 = "Company2"
$none = "NONE SET"

# OS Tag values
$categoryos = "OS"
$microsoft = "Windows"
$linux = "Linux"

##############
# End Config
##############

# Loop through vCenters in array
foreach ($v in $vcenterarry) {

    # Connect to vcenter (authenticate manually)
    Connect-VIServer -Server $v

    # Get datacenters
    $datacenters = Get-Datacenter

    # Loop datacenters
    foreach ($d in $datacenters) {
        Write-host "Datacenter ="$d -ForegroundColor "Green"
        # Get all VMs

        $vmlist = Get-Datacenter $d | Get-VM | select -ExpandProperty Name | Sort-Object

        # Loop though VMs
        foreach ($vm in $vmlist) {

            # Get Guest os for VM
            $vmos = Get-VM -Name $vm | Get-VMGuest | select -ExpandProperty OSFullName

            if ($vmos -like "*Microsoft*") {
                $ostag = $Microsoft
            }

            else {
                $ostag = $Linux
            }

             # Start looping through looking for naming matches, if found then add relevant company tag and os tag
            if ($vm -like "*UKLON*") {

                # If Company tag present but doesnt match tag value in config section, remove it and re add the correct tag with correct valye

                If ((Get-Tagassignment $vm).Company -ne $Company2) {

                    Get-VM -Name $vm | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company2) | Out-Null

                }

                # If OS tag present but doesnt match tag value in config section, remove it and re add the correct tag with correct valye

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company2 $ostag -ForegroundColor "Blue"
            }
              elseif ($vm -like "*USNEW*") {

                If ((Get-Tagassignment $vm).Company -ne $Company2) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company2) | Out-Null

                }

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company2 $ostag -ForegroundColor "Blue"
            }
            elseif ($vm -like "*UKAZ*") {

                If ((Get-Tagassignment $vm).Company -ne $Company2) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company2) | Out-Null

                }

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company2 $ostag -ForegroundColor "Blue"

            }

            elseif ($vm -like "*UKAWS*") {

                If ((Get-Tagassignment $vm).Company -ne $Company2) {

                    Get-VM -Name $vm | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company2) | Out-Null

                }

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company2 $ostag -ForegroundColor "Blue"

            }

            elseif ($vm -like "*UKSCO*") {

                If ((Get-Tagassignment $vm).Company -ne $Company1) {

                    Get-VM -Name $vm | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company1) | Out-Null

                }

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company1 $ostag -ForegroundColor "Blue"

            }

            elseif ($vm -like "*UKWAL*") {

                If ((Get-Tagassignment $vm).Company -ne $Company1) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $Company1) | Out-Null

                }

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $Company1 $ostag -ForegroundColor "Blue"

            }        

   
            # If no names match any of the above set the Company tag value as $none in config

            else {

                Get-VM -Name $vm | Get-TagAssignment -Category $category | Remove-TagAssignment -Confirm:$false | Out-Null

                Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $category -Name $none) | Out-Null

               

                If ((Get-Tagassignment $vm).OS -ne $ostag) {

                    Get-VM -Name $vm  | Get-TagAssignment -Category $categoryos | Remove-TagAssignment -Confirm:$false | Out-Null

                    Get-VM -Name $vm | New-TagAssignment -Tag (Get-Tag -Category $categoryos -Name $ostag) | Out-Null

                }

                Write-Host $vm $none $ostag -ForegroundColor "Blue"

            }

        }

    }

}
# Disconnect vcenters

Disconnect-VIServer * -Confirm:$false