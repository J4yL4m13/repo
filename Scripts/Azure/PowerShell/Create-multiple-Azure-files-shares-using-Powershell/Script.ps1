<#
.SYNOPSIS
Created by James Lambert
www.roonics.com

.DESCRIPTION
    This script creates shares from a txt file in Azure and set's their access tier

.EXAMPLE

.OUTPUTS

.NOTES

#>

# CONFIG START
$file = Get-Content -Path "shares.txt"
$accessTier = "Hot"
$tenant = "<tenant id>"
$subscription = "<subscription id>"
$resourceGroupName = "<resource group>"
$storageAccountName = "<storage account name>"
# CONFIG END

# CONNECT TO AZURE
Connect-AzAccount -Tenant $tenant -SubscriptionId $subscription

# GET STORAGE KEY
$storageKey = (Get-AzStorageAccountKey `
        -ResourceGroupName $resourceGroupName `
        -Name $storageAccountName).Value[0]

# BUILD CONTEXT THEN LOOP THROUGH TXT FILE AND CREATE SHARES
$storageContext = New-AzStorageContext `
    -StorageAccountName $storageAccountName `
    -StorageAccountKey $storageKey

foreach ($line in $file) {
    $shareName = $line
    New-AzStorageShare `
        -Name $shareName `
        -Context $storageContext

    $updateParams = @{
        ResourceGroupName  = $resourceGroupName
        StorageAccountName = $storageAccountName
        Name               = $line
    }

    if ($null -ne $accessTier) { $updateParams += @{ AccessTier = $accessTier } }

    # UPDATE ACCESS TIER
    Update-AzRmStorageShare @updateParams
}