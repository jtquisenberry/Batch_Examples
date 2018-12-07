##Change this to suite your needs

## Create an Timer instance
##$timer = New-Object Timers.Timer

## Now setup the Timer instance to fire events
##$timer.Interval = 2000     # fire every 2s
##$timer.AutoReset = $false  # do not enable the event again after its been fired
##$timer.Enabled = $true

## register your event
## $args[0] Timer object
## $args[1] Elapsed event properties
## Register-ObjectEvent -InputObject $timer -EventName Elapsed -SourceIdentifier Notepad  -Action {notepad.exe}
##Register-ObjectEvent -InputObject $timer echo "Dogs"

$timeout = new-timespan -Minutes 2000
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){
    ##echo "dogs"
 
 ## & is the call operator.
 
 & "C:\temp\curl.exe" '"https://rum-cloud.kcura.com/rum/a.gif?px=0.91125^&py=0.5994152046783626^&rx=0.5^&ry=0.1111111111111111^&ctmp=2017-02-28T17^%^3A31^%^3A20.141Z^&ltmp=Tue+Feb+28+2017+09^%^3A31^%^3A20+GMT-0800+(Pacific+Standard+Time)^&uid=1042909^&wid=1042995^&url=^%^2FRelativity^%^2FCase^%^2FCase^%^2FView.aspx^%^3FAppID^%^3D1042995^%^26ArtifactID^%^3D1042995^%^26SelectedTab^%^3D1034252^&pid=RelativityCaseCaseViewaspx^&atid=NaN^&eid=_viewTemplate__kCuraScrollingDiv__manageWorspacePermissions_anchor^&b=Chrome+56.0^&hotd=9^&secoh=20^&df=false^&mi=^&to=-8^&ua=Mozilla^%^2F5.0+(Windows+NT+6.1^%^3B+WOW64)+AppleWebKit^%^2F537.36+(KHTML^%^2C+like+Gecko)+Chrome^%^2F56.0.2924.87+Safari^%^2F537.36^&os=Win32^&lang=en-US^&relver=9.4.398.62^&rumver=1.0^&inst=NV_REL94DEV^&rumid=rum_9c954805-d319-443e-82c6-6d5df7f78a23_nv_rel94dev" -H "Accept: image/webp,image/*,*/*;q=0.8" -H "Connection: keep-alive" -H "Accept-Encoding: gzip, deflate, sdch, br" -H "Referer: http://www.mywebsite.com" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36" --compressed -w "\r\n%{http_code}\r\n"'
 
 echo ""
 
    start-sleep -seconds 120
}
 
write-host "Timed out"