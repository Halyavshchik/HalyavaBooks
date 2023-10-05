function Test-CommandExists ($command) {
 try {
  if (Get-Command $command -ErrorAction SilentlyContinue) {
   return $true
  }
 }
 catch {
  return $false
 }
}

$isScoopInstalled = Test-CommandExists scoop
if (-not $isScoopInstalled) {
 Invoke-WebRequest get.scoop.sh | Invoke-Expression
}

$install = "scoop install"

$isPythonInstalled = ((Test-CommandExists py.exe) -and ((py.exe --list | Out-String) -like "*3.11*"))
if (-not $isPythonInstalled) {
 $install += " python311"
}

$isPandocInstalled = Test-CommandExists marp.exe
if (-not $isPandocInstalled) {
 $install += " marp"
}

$isPoetryInstalled = Test-CommandExists poetry.exe
if (-not $isPoetryInstalled) {
 $install += " poetry"
}

if (-not ($install -contains "scoop install")) {
 Invoke-Expression $install
}

poetry install
