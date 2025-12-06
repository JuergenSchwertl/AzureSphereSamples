enum SensorType { 
    BME280 
    BMP280
    AVNETSK2 
}

[SensorType] $ProjectType = [SensorType]::BMP280

[string] $Project = "SphereBME280"
[string] $Product = "IoTC OfficeClimate"
[string] $DeviceGroupBME280 = "SphereBME280 Eval"
[string] $DeviceGroupBMP280 = "SphereBMP280 Eval"
[string] $DeviceGroupAVNETSK2 = "AVNET SK v2 Eval"

[string] $ImagePackage = $Project + ".imagepackage"
[string] $OutPath = "out"
[string] $DebugPath = "ARM-Debug"
[string] $ReleasePath = "ARM-Release"
[string] $DeviceGroup = [string]::Empty


#[string] $CurrentPath = $PSScriptRoot
[string] $CurrentPath = "C:/repos/AzureSphereSamples/SphereBME280"

[string] $ImagePackagePath = $CurrentPath +"\"+ $OutPath +"\"+ $ReleasePath +"\"+ $ImagePackage

if( -not (Test-Path -Path $ImagePackagePath) )
{
    write-error "File ${ImagePackagePath} doesn't exist."
    Abort
}
$r = (&azsphere image-package show --image-package $ImagePackagePath --output json) | ConvertFrom-Json
$ImageId = $r.Identity.ImageId

&azsphere image add --image $ImagePackagePath 

switch( $ProjectType )
{
    BME280 { $DeviceGroup = $Product+"/"+$DeviceGroupBME280 }
    BMP280 { $DeviceGroup = $Product+"/"+$DeviceGroupBMP280 }
    AVNETSK2 { $DeviceGroup = $Product+"/"+$DeviceGroupAVNETSK2 }
}

Write-Host "Creating Deployment in DeviceGroup ""${DeviceGroup}"" with ImageId ${ImageId}."

$dep = (&azsphere device-group deployment create --device-group $DeviceGroup --images $ImageId --output json) | ConvertFrom-Json

$DeploymentId = $dep.id 

Write-Host "Created Deployment $DeploymentId"

$dg = (&azsphere device-group show --device-group $DeviceGroup --output json) |  ConvertFrom-Json

Write-Host (ConvertTo-Json $dg)
