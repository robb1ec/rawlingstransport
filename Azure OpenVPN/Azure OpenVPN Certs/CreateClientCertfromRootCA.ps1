# find the thumbprint for the next command with Get-ChildItem -Path "Cert:\CurrentUser\My" 

Get-ChildItem -Path "Cert:\CurrentUser\My"
exit 0

# look for Root Cert to get thumbprint to pass to next command per here:
# Thumbprint                                Subject
# ----------                                -------
# AED812AD883826FF76B4D1D5A77B3C08EFA79F3F  CN=P2SChildCert4
# 7181AA8C1B4D34EEDB2F3D3BEC5839F3FE52D655  CN=P2SRootCert

$cert=get-childitem -path "Cert:\CurrentUser\My\A12CA532EB32774A0E5033976EE3FD7F935A70BC"

$params = @{
       Type = 'Custom'
       Subject = 'CN=trustitsolutions.accountant'
       DnsName = 'P2SChildCert'
       KeySpec = 'Signature'
       KeyExportPolicy = 'Exportable'
       KeyLength = 2048
       HashAlgorithm = 'sha256'
       NotAfter = (Get-Date).AddMonths(120)
       CertStoreLocation = 'Cert:\CurrentUser\My'
       Signer = $cert
       TextExtension = @(
        '2.5.29.37={text}1.3.6.1.5.5.7.3.2')
   }
   New-SelfSignedCertificate @params
