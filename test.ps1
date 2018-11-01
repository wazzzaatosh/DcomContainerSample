$pester = Get-Module 'Pester' -ListAvailable
if( -not $pester ) { Install-Module 'Pester' -Repository PSGallery }
Import-Module Pester

Invoke-Pester -Script "$PSScriptRoot\pester.ps1"