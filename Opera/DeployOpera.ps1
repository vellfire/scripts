# Define file paths
$deploymentPropertiesPath = "C:\Windows\Sun\Java\Deployment\deployment.properties"
$exceptionSitesPath = "C:\Windows\Sun\Java\Deployment\exception.sites"
$ieModeSiteListPath = "C:\Users\Public\Documents\IEMode.xml"

# Define content for deployment.properties
$deploymentPropertiesContent = @"
deployment.system.config.mandatory=True
deployment.user.security.exception.sites=C\:\\Windows\\Sun\\Java\\Deployment\\exception.sites
deployment.security.tls.revocation.check=NO_CHECK
"@

# Define content for exception.sites
$exceptionSitesContent = @"
https://example-oc-sc.oracleindustry.com
"@

# Define content for IEMode.xml
$ieModeSiteListContent = @"
<site-list version="1">
  <site url="example-oc-sc.oracleindustry.com/">
    <compat-mode>Default</compat-mode>
    <open-in allow-redirect="true">IE11</open-in>
  </site>
</site-list>
"@

# Create deployment.properties
Write-Host "Creating deployment.properties"
Set-Content -Path $deploymentPropertiesPath -Value $deploymentPropertiesContent

# Create exception.sites
Write-Host "Creating exception.sites"
Set-Content -Path $exceptionSitesPath -Value $exceptionSitesContent

# Create IEMode Site List
Write-Host "Creating IEMode Site List"
Set-Content -Path $ieModeSiteListPath -Value $ieModeSiteListContent

pause
