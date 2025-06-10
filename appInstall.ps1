param ($debug = $False)

Add-Type -AssemblyName System.Windows.Forms

# Variables
$showPopup      = $False
$popupMessage   = $null
$prog1          = $null
$arg1           = $null
$msi1           = $null
$prog2          = $null
$arg2           = $null
$msi2           = $null
$prog3          = $null
$arg3           = $null
$msi3           = $null

$vars = @(
    [ref]$showPopup, 
    [ref]$popupMessage, 
    [ref]$prog1, 
    [ref]$arg1,
    [ref]$msi1,
    [ref]$prog2, 
    [ref]$arg2,
    [ref]$msi2, 
    [ref]$prog3, 
    [ref]$arg3,
    [ref]$msi3
)

$varNames = @(
    'showPopup', 
    'popupMessage', 
    'prog1', 
    'arg1',
    'msi1',
    'prog2', 
    'arg2',
    'msi2', 
    'prog3', 
    'arg3',
    'msi3'
)

# Display PopUp message during install
function displayPopUp  {
    param ($message)

    # Create a hidden, topmost form
    $topmostForm = New-Object System.Windows.Forms.Form
    $topmostForm.TopMost = $true
    $topmostForm.ShowInTaskbar = $false
    $topmostForm.WindowState = 'Minimized'
    $topmostForm.Show()
    $topmostForm.Hide()

    # Show the message box with the topmost form as owner
    [System.Windows.Forms.MessageBox]::Show($topmostForm, $message, 'Popup Message')

    # Dispose the form after use
    $topmostForm.Dispose()

}

# Read in Text file
function readIni {
    param ([string]$fileName = "config.ini")
    $i = 0

    foreach ($line in Get-Content -Path $fileName) {
        # Prevent out of bounds errors
        if ($i -ge $vars.Count) {break}

        if (![string]::IsNullOrWhiteSpace($line)) {
            $value = $line.Substring($line.LastIndexOf(":") + 1).Trim()
            $vars[$i].Value = $value
            $i++
        }
    }
}

# Start-process function
function installMe {
    param ($app, $appArgs, $msi = $False)

    if ($msi -eq $True) {
        Start-Process -FilePath "msiexec.exe" -WorkingDirectory "C:\Windows\System32\" -ArgumentList $app, $appArgs -Wait
    }
    else {
        Start-Process -FilePath ".\$app" -ArgumentList "$appArgs"
    }
}

# Main execution

# 1) Read in a text file
readIni

if ($debug -eq $True) {
    Write-Output $vars.Count
    for ($i = 0; $i -lt $vars.Count; $i++) {
        Write-Output "$($varNames[$i]): $($vars[$i].Value)"
    }
}

# 2) Display a popup message?
if ($showPopup -match $True) { displayPopUp -message $popupMessage }

# 3) Execute some code
# Program 1
if ($null -ne $prog1.Value) { installMe -app $prog1 -appArgs $arg1 -msi $msi1 }

if ($debug -eq $true) {
    Write-Output "app: $prog1, appArgs: $arg1, MSI: $msi1"
}

# Program 2
if ($null -ne $prog2l.Value) { installMe -app $prog2 -appArgs $arg2 -msi $msi2 }

if ($debug -eq $true) {
    Write-Output "app: $prog2, appArgs: $arg2, MSI: $msi2"
}

# Program 3
if ($null -ne $prog3.Value) { installMe -app $prog3 -appArgs $arg3 -msi $msi3 }

if ($debug -eq $true) {
    Write-Output "app: $prog3, appArgs: $arg3, MSI: $msi3"
}