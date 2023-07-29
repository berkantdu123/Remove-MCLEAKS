# Define the path to the hosts file
$hostsFilePath = "$env:windir\System32\drivers\etc\hosts"

# Function to get the short path (8.3 filename) of a given path
function Get-ShortPath {
    param (
        [string]$path
    )
    $shortPath = Get-Item $path | ForEach-Object { $_.GetShortPathName() }
    return $shortPath
}

# Function to take ownership of the file using takeown command-line utility
function Take-Ownership {
    param (
        [string]$path
    )
    try {
        $shortPath = Get-ShortPath -path $path
        & takeown.exe /F "$shortPath" /A /R /D Y | Out-Null
        Write-Output "Ownership successfully taken."
    }
    catch {
        Write-Output "Failed to take ownership: $_"
        return $false
    }
    return $true
}

# Function to revert ownership to its original state using icacls command-line utility
function Revert-Ownership {
    param (
        [string]$path
    )
    try {
        $shortPath = Get-ShortPath -path $path
        & icacls.exe "$shortPath" /setowner Administrators /T /C | Out-Null
        Write-Output "Ownership successfully reverted."
    }
    catch {
        Write-Output "Failed to revert ownership: $_"
        return $false
    }
    return $true
}

# Function to remove specific lines from the file
function Remove-HostsLines {
    param (
        [string]$path,
        [string[]]$linesToRemove
    )
    try {
        $content = Get-Content $path
        $modifiedContent = $content | Where-Object { $_ -notmatch ($linesToRemove -join '|') }
        $modifiedContent | Set-Content $path
        Write-Output "Hosts file modified successfully."
    }
    catch {
        Write-Output "Failed to modify the hosts file: $_"
        return $false
    }
    return $true
}

# Main script
try {
    # Take ownership of the hosts file
    if (!(Take-Ownership -path $hostsFilePath)) {
        throw "Failed to take ownership."
    }

    # Lines to remove
    $linesToRemove = @("127.0.0.1 sessionserver.mojang.com", "127.0.0.1 authserver.mojang.com")

    # Remove lines from the hosts file
    if (!(Remove-HostsLines -path $hostsFilePath -linesToRemove $linesToRemove)) {
        throw "Failed to remove lines from the hosts file."
    }

    # Revert ownership to its original state
    if (!(Revert-Ownership -path $hostsFilePath)) {
        throw "Failed to revert ownership."
    }

    Write-Output "Script executed successfully."
}
catch {
    Write-Output "An error occurred: $_"
}
