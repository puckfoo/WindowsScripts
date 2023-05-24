<#

Digitally Sign a PowerShell Script

1. Separate custom developed, tested and personal scripts
2. Ensure scripts are not malicious
3. Validate that the script is doing versus its intended purpose

Understanding Script Signing
1. Must sign a script with a code signing cert
2. Two types of certificates are suitable for signing a script file: Public Certification Authority and Self-Signed. 
3. Use a self-signed certificate only to sign scripts that you write for personal use.

Certficate Types
1. Public Cetification authorty
2. Locally created self-signed

#>


#Set the PowerShell Script Path
$script = "C:\Users\Richard Holland\OneDrive\scripts\script.ps1"

#Create Self-Signed code Signing Certificate
New-SelfSignedCertificate -DnsName "script.puckfoo.com" -CertStoreLocation Cert:\CurrentUser\My -Type CodeSigningCert -Subject "PowerShell Code Signing Certfictate"

#Retreive the Code Signing Certficate
$certificate = (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0]

#Set the Code Signing Certficate for the PowerShell Script
Set-AuthenticodeSignature $script -Certificate $certificate

#Validate the Code Signing Certificate
Get-AuthenticodeSignature $script | Format-Table -AutoSize


#Deploy Cert








