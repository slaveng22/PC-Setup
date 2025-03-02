# Run as administrator

# Uninstall common bloatware
$Bloatware = @(
    "Microsoft.BingWeather",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MixedReality.Portal",
    "Microsoft.People",
    "Microsoft.SkypeApp",
    "Microsoft.Todos",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo"
)

foreach ($app in $Bloatware) {
    Get-AppxPackage -Name $app | Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -Like "$app" | Remove-AppxProvisionedPackage -Online -AllUsers
}

# Disable Telemetry & Tracking
$registryPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
)

foreach ($path in $registryPaths) {
    if (!(Test-Path $path)) { New-Item -Path $path -Force }
}

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name AllowTelemetry -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name TailoredExperiencesWithDiagnosticDataEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name DisableWindowsConsumerFeatures -Type DWord -Value 1

# Disable ads & suggestions
$adsRegistry = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
)

foreach ($path in $adsRegistry) {
    if (!(Test-Path $path)) { New-Item -Path $path -Force }
}

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SystemPaneSuggestionsEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338389Enabled -Type DWord -Value 0

# Enable dark mode
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Type DWord -Value 0

# Enable file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Type DWord -Value 0

# Restart Explorer to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer