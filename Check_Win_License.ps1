##### Check Win License
## v 1.0
##
## by Brom

# Initialize variables
$licenseStatus = 0
$productKey = ""
$uefiKey = ""

# Retrieve license status and keys
$licenseStatus = (Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object { $_.Name -match "Windows" -and $_.PartialProductKey } | Select-Object -ExpandProperty LicenseStatus)
$uefiKey = (Get-CimInstance -ClassName SoftwareLicensingService).OA3xOriginalProductKey
$productKey = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name BackupProductKeyDefault).BackupProductKeyDefault

# Display license status
switch ($licenseStatus) {
	1 { Write-Host "Windows license valid`nRegistry Windows Key: $productKey`nUEFI Windows Key: $uefiKey" }
	0 { Write-Host "!! Windows not licensed !!" }
	2 { Write-Host "Out-Of-Box Grace Period" }
	3 { Write-Host "Out-Of-Tolerance Grace Period" }
	4 { Write-Host "Non-Genuine Grace Period" }
	5 { Write-Host "Notification" }
	6 { Write-Host "Extended Grace" }
	default { Write-Host "Value not found" }
}

# Exit the script
exit
