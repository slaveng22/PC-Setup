git clone git@github.com:slaveng22/WorkMadeEasy_Module.git
Copy-Item -Path .\WorkMadeEasy_Module\WorkMadeEasy -Destination $env:USERPROFILE\Documents\PowerShell\Modules\WorkMadeEasy -Recurse -Force
Unblock-File -Path $env:USERPROFILE\Documents\PowerShell\Modules\WorkMadeEasy\WorkMadeEasy.psd1
Unblock-File -Path $env:USERPROFILE\Documents\PowerShell\Modules\WorkMadeEasy\WorkMadeEasy.psm1