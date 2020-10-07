#     > powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JUpdM')"

$tweaks = @(
	### Require administrator privileges ###
	"RequireAdmin",
  "Unprovision"
)

function Unprovision {
	Write-Output "Uninstalling default third party applications..."
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.BingWeather_4.8.19002.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.GetHelp_10.2004.31291.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Getstarted_9.10.32461.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Microsoft3DViewer_2020.2009.29132.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MicrosoftOfficeHub_18.2008.12711.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MicrosoftSolitaireCollection_4.7.8101.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MixedReality.Portal_2000.20081.1312.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.MSPaint_2020.2009.30067.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Office.OneNote_16001.13127.20190.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.People_2020.324.807.0_neutral_~_8wekyb3d8bbwe"
  Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.SkypeApp_15.64.80.0_neutral_~_kzf8qxf38zg5c"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.StorePurchaseApp_12009.1001.113.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.VCLibs.140.00_14.0.27323.0_x64__8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Wallet_2.4.18324.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.WindowsAlarms_2021.2007.3.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.WindowsCamera_2020.504.60.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.WindowsFeedbackHub_2019.1111.2029.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.WindowsMaps_2021.2008.0.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.WindowsSoundRecorder_2021.2008.0.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.XboxApp_48.69.18001.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.XboxIdentityProvider_12.67.21001.0_neutral_~_8wekyb3d8bbwe"
	Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_neutral_~_8wekyb3d8bbwe"
  Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.YourPhone_2020.923.45.0_neutral_~_8wekyb3d8bbwe"
  Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.ZuneMusic_2019.20082.10421.0_neutral_~_8wekyb3d8bbwe"
  Remove-AppxProvisionedPackage -Online -PackageName "Microsoft.ZuneVideo_2019.20082.10421.0_neutral_~_8wekyb3d8bbwe"

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
