# Function to check if an application is installed

## todo: better is installed check
function Is-AppInstalled {
    param (
        [string]$appName
    )

    $app = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName -like "*$appName*" }
    return $app -ne $null
}

# Function to install Visual Studio Code
function Install-VSCode {
    if (-not (Is-AppInstalled -appName "Visual Studio Code")) {
        Write-Output "Installing Visual Studio Code..."
        $installerPath = "$env:TEMP\vscode-installer.exe"
        Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile $installerPath
        Start-Process -FilePath $installerPath -ArgumentList "/silent", "/mergetasks=!runcode" -Wait
        Remove-Item $installerPath
        Write-Output "Visual Studio Code installed successfully."
    } else {
        Write-Output "Visual Studio Code is already installed."
    }
}

# Function to install Python
function Install-Python {
    if (-not (Is-AppInstalled -appName "Python")) {
        Write-Output "Installing Python..."
        $installerPath = "$env:TEMP\python-installer.exe"
        Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe" -OutFile $installerPath
        Start-Process -FilePath $installerPath -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait
        Remove-Item $installerPath
        Write-Output "Python installed successfully."
    } else {
        Write-Output "Python is already installed."
    }
}

# Function to install Git
function Install-Git {
    if (-not (Is-AppInstalled -appName "Git")) {
        Write-Output "Installing Git..."
        $installerPath = "$env:TEMP\git-installer.exe"
        Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe" -OutFile $installerPath
        Start-Process -FilePath $installerPath -ArgumentList "/silent" -Wait
        Remove-Item $installerPath
        Write-Output "Git installed successfully."
    } else {
        Write-Output "Git is already installed."
    }
}

# Function to check Python installation and install PyGame
function Install-PyGame {
    # Check if Python is in the PATH
    if (Get-Command py -ErrorAction SilentlyContinue) {
        Write-Output "Python is installed and available in PATH."
        Write-Output "Installing PyGame..."
        py -m pip install pygame
        Write-Output "PyGame installed successfully."
    } else {
        Write-Output "Python is not installed or not found in PATH. Please ensure Python is installed and in the system PATH."
    }
}

# Start installation process
Install-VSCode
Install-Python
Install-Git

# Verify Python installation and install PyGame
Install-PyGame

Write-Output "All installations and configurations are complete."
