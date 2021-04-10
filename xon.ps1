# Gets hold of the location of the system-wide PHP installation, and enables the XDebug
# extension by uncommenting its extension loading line.

# Get hold of the PHP php.ini file.
$phpIniFullOutput = (php --ini) | Select-String -Pattern 'Loaded Configuration File:'
$phpIniFilePath = ($phpIniFullOutput -split 'Loaded Configuration File:')[1].Trim()

if([string]::IsNullOrWhiteSpacE($phpIniFilePath)){
	Write-Host "php.ini file could not be found."
	exit 1
}

# Replace in place.
(Get-Content -Path $phpIniFilePath) -replace '^;(zend_extension\s?=.*xdebug.*.dll$)', '$1' | Set-Content $phpIniFilePath

# Display the current PHP version information to debug the effect of the command.
php -v
