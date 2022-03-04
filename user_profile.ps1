. $env:USERPROFILE\.config\powershell\user_profile.ps1


# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Load prompt config
# $scriptName = Split-Path -Path $MyInvocation.MyCommand.Definition -Leaf
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$omp_config = Join-Path (Get-ScriptDirectory) 'nomionz.omp.json'
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
Set-PoshPrompt M365Princess

Import-Module -Name Terminal-Icons

# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch {
  Param(
    [Parameter(Mandatory=$true)]
    [string]$Path
  )

  if (Test-Path -LiteralPath $Path) {
    (Get-Item -Path $Path).LastWriteTime = Get-Date
  } else {
    New-Item -Type File -Path $Path
  }
}
