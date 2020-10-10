#     > powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JUpdM')"

$tweaks = @(
	### Require administrator privileges ###
	"RequireAdmin",
  "Unprovision"
)

function Unprovision {
	Write-Output "Uninstalling default third party applications..."
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.549981C3F5F10_2.2009.23741.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.BingWeather_4.25.20211.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.DesktopAppInstaller_2019.1019.1.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MicrosoftOfficeHub_18.1903.1152.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MixedReality.Portal_2000.19081.1301.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MSPaint_2019.729.2301.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Office.OneNote_16001.12026.20112.0_neutral_~_8wekyb3d8bbwe"
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.VP9VideoExtensions_1.0.32521.0_x64__8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.WindowsCamera_2018.826.98.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.XboxApp_48.49.31001.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.XboxGameOverlay_1.46.11001.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.XboxGamingOverlay_2.34.28001.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe
  Remove-AppxProvisionedPackage -Online -PackageName Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe

}

##########
# Parse parameters and apply tweaks
##########

# Normalize path to preset file
$preset = ""
$PSCommandArgs = $args
If ($args -And $args[0].ToLower() -eq "-preset") {
	$preset = Resolve-Path $($args | Select-Object -Skip 1)
	$PSCommandArgs = "-preset `"$preset`""
}

# Load function names from command line arguments or a preset file
If ($args) {
	$tweaks = $args
	If ($preset) {
		$tweaks = Get-Content $preset -ErrorAction Stop | ForEach { $_.Trim() } | Where { $_ -ne "" -and $_[0] -ne "#" }
	}
}

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }
