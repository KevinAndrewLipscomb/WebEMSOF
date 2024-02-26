[CmdletBinding()]
Param
  (
  [string]
  [Parameter(Position=0)]
  [ValidateNotNullOrEmpty()]
  [ValidateSet("d","x","p")]
    $TargetEnvironment = $(Read-Host "[-TargetEnvironment] ... Refresh which target environment (d or x)?"),
  [string]
  [Parameter(Position=1)]
  [ValidateNotNullOrEmpty()]
  [ValidateScript({Test-Path $_})]
    $LoadScriptFolder = $(Read-Host "[-LoadScriptFolder] ... Using load script from which folder?")
  )
#
$base_db_name = "emsidb"
#
$targetEnvironmentSuffix = switch ($TargetEnvironment)
  {
  "d" { "_d" }
  "x" { "_x" }
  "p" { "" }
  }
$db_instance = "$base_db_name$targetEnvironmentSuffix"
mysql --user=root --execute="quit" # to test the connection
if ($LASTEXITCODE -eq 1)
  {
  mysql_config_editor set --host=localhost --user=root --password
  }
Write-Host -NoNewline "Dropping schema $db_instance..."
mysql --execute="drop schema $db_instance"
Write-Host "DONE."
Write-Host -NoNewline "Creating schema $db_instance..."
mysql --execute="create schema $db_instance"
Write-Host "DONE."
Write-Host -NoNewline "Populating instance appropriately..."
Get-Content (Join-Path -Path $LoadScriptFolder -ChildPath "$base_db_name.sql") -Encoding:UTF8 |
  ForEach-Object { $_ -creplace "NO_AUTO_CREATE_USER,","" } |
  mysql --database=$db_instance
Write-Host "DONE."
if ("$db_instance" -ne "$base_db_name")
  {
  Write-Host -NoNewline "Isolating instance from production stakeholders..."
  Get-Content 0-render-safe-for-d-or-x.sql |
    mysql --database=$db_instance
  Write-Host "DONE."
  }
Write-Host "$($(Get-ChildItem $PsCommandPath).BaseName) COMPLETE."
Pause
