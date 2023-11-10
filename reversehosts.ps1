# Define the path to the hosts file
$hostsFilePath = "$env:windir\System32\drivers\etc\hosts"

# Function to remove lines containing a specific pattern using regex
function Remove-HostsLines {
    param (
        [string]$path,
        [string]$pattern
    )
    try {
        # Capture the original owner
        $originalOwner = (Get-Item "$path").GetAccessControl().Owner

        # Take ownership of the hosts file
        & icacls.exe "$path" /setowner Administrators /T /C | Out-Null

        Write-Host "Changed ownership to" (Get-Item "$path").GetAccessControl().Owner

        # Get the content of the hosts file
        $content = Get-Content $path

        # Remove lines matching the pattern using regex
        $modifiedContent = $content | Where-Object { $_ -notmatch $pattern }

        # Write the modified content back to the hosts file
        $modifiedContent | Set-Content $path

        Write-Host "Hosts file modified successfully."

        & ipconfig /flushdns
        Write-Host "IpConfig sucessfully flushed."
    }
    catch {
        Write-Host "Failed to modify the hosts file: $_"
        return $false
    }

    # Revert ownership to its original state
    try {
        & icacls.exe "$path" /setowner $originalOwner | Out-Null
        Write-host "Ownership changed back to "(Get-Item "$path").GetAccessControl().Owner
        Write-Host "Ownership successfully reverted."
    }
    catch {
        Write-Host "Failed to revert ownership: $_"
        return $false
    }

    return $true
}

# Main script
try {
    # Define the pattern to match lines
    $pattern = "mojang"

    # Remove lines matching the pattern from the hosts file
    if (!(Remove-HostsLines -path $hostsFilePath -pattern $pattern)) {
        throw "Failed to remove lines from the hosts file."
    }
    $userResponse = Read-Host "Do you want to restart your computer now for best compatibility? Although not required this may improve the success rate, make sure to save your work before. (y/n)"
    if ($userResponse -eq "y" -or $userResponse -eq "Y") {
        Restart-Computer -Force
    }
    Write-Host "Script executed successfully."
}
catch {
    Write-Host "An error occurred: $_"
}
