
$certs = Get-ChildItem -Path Cert:\LocalMachine\My
$sconns = Get-SendConnector | where -FilterScript {$_.tlscertificatename -ne $null}
foreach ( $item in $sconns ) {
	$certname = $item.tlscertificatename
	$certsubj = $certname.CertificateSubject
	$detail = $certs | where {$_.Subject -eq $certsubj }
	$FN = $detail.FriendlyName
	$NA = $detail.NotAfter
    $server = $item.server
    $identity = $item.identity
    "SeverName: $server"
    "ConnectorName: $identity"
	"CertificateSubject: $certsubj"
	"FriendlyName: $FN"
	"Expires: $NA"
	""
} 






$certs = Get-ChildItem -Path Cert:\LocalMachine\My
$rconns = Get-SendConnector | where -FilterScript {$_.tlscertificatename -ne $null}
foreach ( $item in $rconns ) {
	$certname = $item.tlscertificatename
	$certsubj = $certname.CertificateSubject
	$detail = $certs | where {$_.Subject -eq $certsubj }
	$FN = $detail.FriendlyName
	$NA = $detail.NotAfter
    $server = $item.server
    $identity = $item.identity
    "SeverName: $server"
    "ConnectorName: $identity"
	"CertificateSubject: $certsubj"
	"FriendlyName: $FN"
	"Expires: $NA"
	""
} 
