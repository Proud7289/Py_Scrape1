# Define the GeckoDriver version to download
$geckoDriverVersion = "v0.35.0"  # Check the latest compatible version with Firefox 129.0.1
$downloadUrl = "https://github.com/mozilla/geckodriver/releases/download/$geckoDriverVersion/geckodriver-$geckoDriverVersion-win64.zip"

# Download the GeckoDriver zip file
$geckoDriverZipPath = "$env:TEMP\geckodriver.zip"
Invoke-WebRequest -Uri $downloadUrl -OutFile $geckoDriverZipPath

# Extract the zip file
$geckoDriverExtractPath = "$env:ProgramFiles\GeckoDriver"
Expand-Archive -Path $geckoDriverZipPath -DestinationPath $geckoDriverExtractPath

# Add the GeckoDriver directory to the system PATH
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
if (-not ($envPath -like "*$geckoDriverExtractPath*")) {
    [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$geckoDriverExtractPath", "Machine")
}

# Clean up the zip file
Remove-Item $geckoDriverZipPath

Write-Host "GeckoDriver has been installed and added to the system PATH."
