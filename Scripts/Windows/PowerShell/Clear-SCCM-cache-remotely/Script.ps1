<#
.SYNOPSIS
Created by James Lambert 2026

.DESCRIPTION
Script to clear out the SCCM cache folder on a remote server

.EXAMPLE

.OUTPUTS

.NOTES
#>

##############
# Start Config
##############
$un = "domain\username"

##############
# End Config
##############

# Prompt for admin credentials
$UserCred = Get-Credential -UserName $un -Message "Enter Admin Credentials"

# Ask for the target server name
$ComputerName = Read-Host "Enter the Server Name"

if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
    Write-Host "Connecting to $ComputerName via WMI..." -ForegroundColor Cyan
    
    try {
        # Connect to WMI to clear the SCCM records first
        # We use -Credential with Get-WmiObject which uses DCOM/RPC instead of WinRM
        Write-Host "Clearing SCCM WMI Records..." -ForegroundColor Yellow
        $WmiElements = Get-WmiObject -ComputerName $ComputerName -Credential $UserCred -Namespace "root\ccm\SoftMgmtAgent" -Class "CacheElement" -ErrorAction SilentlyContinue
        
        if ($WmiElements) {
            foreach ($Element in $WmiElements) {
                $Element.DeleteCacheElement()
                Write-Host "Cleared WMI Reference: $($Element.CacheElementID)" -ForegroundColor Gray
            }
        }

        # Clear the physical folder C:\Windows\ccmcache
        # Since WinRM is down, we use the Admin Share (C$) to delete files remotely
        $RemotePath = "\\$ComputerName\C$\Windows\ccmcache\*"
        
        Write-Host "Deleting physical files via Admin Share: $RemotePath" -ForegroundColor Yellow
        
        # We use a temporary drive mapping to pass the credentials to the file system
        New-PSDrive -Name "RemoteCache" -PSProvider FileSystem -Root "\\$ComputerName\C$\Windows\ccmcache" -Credential $UserCred | Out-Null
        
        Remove-Item "RemoteCache:\*" -Recurse -Force -ErrorAction SilentlyContinue
        
        Remove-PSDrive "RemoteCache"
        Write-Host "Cache folder purged successfully." -ForegroundColor Green
    }
    catch {
        Write-Error "Connection failed. Ensure RPC ports are open and you have Admin rights: $($_.Exception.Message)"
    }
}
else {
    Write-Host "Server $ComputerName is offline." -ForegroundColor Red
}