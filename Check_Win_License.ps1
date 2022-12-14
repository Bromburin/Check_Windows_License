##### Check Win License
## v 1.0
##
## by Brom
## 
$licencestatus = 0
$ProductKey = 0
$License = 0 

$licencestatus = (Get-CimInstance -ClassName SoftwareLicensingProduct | where {$_.name -match ‘windows’-and $_.PartialProductKey}  | select LicenseStatus)
$License = (Get-CimInstance -ClassName SoftwareLicensingService).OA3xOriginalProductKey
$ProductKey = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name BackupProductKeyDefault).BackupProductKeyDefault

		switch ($licencestatus) {
		"@{LicenseStatus=1}" {write-host "Windows license `n Registry Windows Key: $ProductKey `n UEFI Windows Key: $License";break}
		"@{LicenseStatus=0}" {write-host "!!Windows not licensed!!";break}
		"@{LicenseStatus=2}" {write-host "Out-Of-Box Grace Period";break}
		"@{LicenseStatus=3}" {write-host "Out-Of-Tolerance Grace Period";break}
		"@{LicenseStatus=4}" {write-host "Non-Genuine Grace Period";break}
		"@{LicenseStatus=5}" {write-host "Notification";break}
		"@{LicenseStatus=6}" {write-host "Extended Grace";break}
		default {write-host = "value not found"}
		}
exit 