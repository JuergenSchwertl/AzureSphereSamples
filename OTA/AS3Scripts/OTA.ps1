
# relative paths of imagepackages to the OTA sample (under the proviso being built for Debug)
$strIoTConnectHLPath = ".\\IoTConnectHL\\out\\ARM-Debug-2Beta1905\\IoTConnectHL.imagepackage"
$strRedSphereRTPath = ".\\out\\ARM-Debug-2Beta1905\\RedSphereRT\\RedSphereRT.imagepackage"
$strGreenSphereRTPath = ".\\out\\ARM-Debug-2Beta1905\\GreenSphereRT\\GreenSphereRT.imagepackage"
$strBlueSphereRTPath = ".\\out\\ARM-Debug-2Beta1905\\BlueSphereRT\\BlueSphereRT.imagepackage"

# .SYNOPSIS AppInfo structure with Component Name, ComponentID, ImageID and FilePath
Add-Type @"
	public class AppInfo{
		public System.String Name;
		public System.Guid ComponentID;
		public System.Guid ImageID;
		public System.String FilePath;
	}
"@


<# AppInfo structure for IoTConnectHL POSIX application #>
[AppInfo] $IoTConnectHL  = $null
<# AppInfo structure for RedSphereRT real-time application #>
[AppInfo] $RedSphereRT   = $null
<# AppInfo structure for GreenSphereRT real-time application #>
[AppInfo] $GreenSphereRT = $null
<# AppInfo structure for BlueSphereRT real-time application #>
[AppInfo] $BlueSphereRT  = $null


<#
.SYNOPSIS
Extracts ComponentID, ImageID from given imagepackage file.
.DESCRIPTION
Creates CustomPSObject of type AppInfo with Name, ComponentID, ImageID & FilePath properties from 
given imagepackage file.
.PARAMETER Path
Specifies the path to the .imagepackage file
.PARAMETER Name
(Optional) Specifies an alternative component name.
.INPUTS
None. You cannot pipe objects to ExtractFrom-Image.
.OUTPUTS
AppInfo structure containing Name, ComponentID, ImageID, FilePath 
.EXAMPLE
PS> ExtractFrom-ImagePackage -path "./RedSphereRT.imagepackage" -name "Test"
Name ComponentID                          ImageID                              FilePath                  
---- -----------                          -------                              --------                  
Test f4e25978-6152-447b-a2a1-64577582f327 1b45e9b9-d339-4905-89c1-2a0ecf16f665 .\RedSphereRT.imagepackage
#>
function ExtractFrom-ImagePackage( 
	[Parameter(Mandatory=$true)][string] $Path, 
	[string] $Name = "" )
{
    if( (Test-Path -Path $path ) -and ([System.IO.Path]::GetExtension($path) -eq ".imagepackage"))
    {
        $app = New-Object AppInfo
	    $app.Name = $Name
	    $app.FilePath = $Path

        $t = azsphere image show -f $app.FilePath
        if( ($t -is [System.Array]) -and ($t.Length -gt 9) )
        {
            if( $t[3].Contains("Component ID:") )
            {
                $app.ComponentID = [System.Guid]( $t[3].Split(":").Item(1).Trim() )
#                $app.ComponentID = [System.Guid]( $t[3].Split(":").Item(1).Trim() )
            }
            if( $t[4].Contains("Image ID:") )
            {
                $app.ImageID = [System.Guid]( $t[4].Split(":").Item(1).Trim() )
            }
            if( [string]::IsNullOrWhiteSpace($Name) -and $t[9].Contains("Image Name:") )
            {
                $app.Name = $t[9].Split(":").Item(1).Trim()
            }
        }
        Write-Host "ImagePackage $Path has ComponentID $($app.ComponentID) and ImageID $($app.ImageID)."
        return $app
    } else {
        Write-Error "Unable to find imagepackage '$Path'" -ErrorAction Stop
    }
}



<#
.SYNOPSIS
Creates a new ImageSet in Azure Sphere Security Service
.DESCRIPTION
Creates a new ImageSet in Azure Sphere Security Service with the given ImageID(s)
.PARAMETER ImageID
Specifies the image id(s) for the new image-set
.PARAMETER Name
Specifies the name for the new image-set.
.INPUTS
None. You cannot pipe objects to New-AS3ImageSet.
.OUTPUTS
[System.Guid] ImageSetId 
.EXAMPLE
PS> New-AS3ImageSet -ImageID "f4e25978-6152-447b-a2a1-64577582f327", "1b45e9b9-d339-4905-89c1-2a0ecf16f665" -Name "Test"
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3ImageSet( 
	[Parameter(Mandatory=$true)] $ImageID, 
	[Parameter(Mandatory=$true)][string] $Name )
{
    [System.Guid] $imsID = [System.Guid]::Empty
    [string] $imgIDs = $null

    if( $ImageID -is [System.Array])
    { 
        $imgIDs = [System.String]::Join(",", $ImageID)
    } else {
        $imgIDs = $ImageID
    }
    Write-Host "Creating ImageSet '$Name' for ImageID(s) $imgIDs"

    $result = azsphere ims create -m $imgIDs  -n $Name
    if( ($result -is [System.Array]) -and ($result.Length -gt 1) -and $result[1].Contains("Successfully"))
    {
        Write-Host $result[1]
        $imsID = [System.Guid]( $result[1].Split("'").Item(3) )
        azsphere ims show -i $imsID
        return $imsID
    } else {
		Write-Error "Cannot create ImageSet '$Name' for ImageId(s) $imgIDs" -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Creates a new Component in Azure Sphere Security Service
.DESCRIPTION
Creates a new application component in Azure Sphere Security Service with the given ComponentID
.PARAMETER ComponentID
Specifies the component id(s) for the new application component
.PARAMETER Name
Specifies the name for the new image-set.
.INPUTS
None. You cannot pipe objects to New-AS3Component.
.OUTPUTS
[System.Guid] ComponentId for consistency reasons
.EXAMPLE
PS> New-AS3Component -ComponentID "f4e25978-6152-447b-a2a1-64577582f327" -Name "Test"
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3Component(
	[Parameter(Mandatory=$true)] $ComponentID, 
	[Parameter(Mandatory=$true)][string] $Name
)
{
	$result = azsphere com create -i $ComponentID  -n $Name
    if( ($result -is [System.Array]) -and ($result.Length -gt 1) -and $result[1].Contains("Successfully"))
    {
        Write-Host $result[1]
        return $ComponentID
    } else {
		Write-Error $result[1] -ErrorAction Stop
	}
}


<#
.SYNOPSIS
Uploads a new ImagePackage file into an Azure Sphere Security Service Image
.DESCRIPTION
Uploads a new ImagePackage file into an Azure Sphere Security Service Image
.PARAMETER FilePath
Specifies the path to the .imagepackage file
.INPUTS
None. You cannot pipe objects to New-AS3ComponentImage.
.OUTPUTS
[System.Guid] ImageId of the uploaded .imagepackage-file
.EXAMPLE
PS> New-AS3ComponentImage -FilePath ./testfile.imagepackage
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function Add-AS3ComponentImage(
	[Parameter(Mandatory=$true)] $FilePath
)
{
	$result = azsphere com img add -f $FilePath --force
    if( ($result -is [System.Array]) -and ($result.Length -gt 2) -and $result[ $result.Length-2 ].Contains("Successfully"))
    {
        [String] $s = $result[ $result.Length-2 ]
        Write-Host $s
		return [System.Guid]( $s.Split("'").Item(1) )
    } else {
        if($result -is [System.Array])
        {
            if($result.Length > 3)
            {
        		Write-Error $result[ $result.Length-3 ] -ErrorAction Stop
            } else {
                Write-Error $result[0]
            }
        } else {
       		Write-Error "Unspecified Error" -ErrorAction Stop
        }
	}
}

<#
.SYNOPSIS
Checks prerequisites.
.DESCRIPTION
Creates CustomPSObject of type AppInfo with Name, ComponentID, ImageID & FilePath properties from 
given imagepackage file.
.PARAMETER Path
Specifies the path to the .imagepackage file
.PARAMETER Name
(Optional) Specifies an alternative component name.
.INPUTS
None. You cannot pipe objects to ExtractFrom-Image.
.OUTPUTS
AppInfo structure containing Name, ComponentID, ImageID, FilePath 
.EXAMPLE
PS> ExtractFrom-ImagePackage -path "./RedSphereRT.imagepackage" -name "Test"
Name ComponentID                          ImageID                              FilePath                  
---- -----------                          -------                              --------                  
Test f4e25978-6152-447b-a2a1-64577582f327 1b45e9b9-d339-4905-89c1-2a0ecf16f665 .\RedSphereRT.imagepackage
#>
function Check-Prerequisites()
{
	if( -not (Test-Path -Path $strIoTConnectHLPath) )	{
		Write-Error "Cannot find $strIoTConnectHLPath." -ErrorAction Stop
	} else {
		$Global:IoTConnectHL = ExtractFrom-ImagePackage -Path $strIoTConnectHLPath -Name "IoTConnect-App (POSIX)"
	}
	if( -not (Test-Path -Path $strRedSphereRTPath) )	{
		Write-Error "Cannot find $strRedSphereRTPath" -ErrorAction Stop
	} else {
		$Global:RedSphereRT = ExtractFrom-ImagePackage -Path $strRedSphereRTPath -Name "RedSphere-App (real-time)"
	}
	if( -not (Test-Path -Path $strGreenSphereRTPath) )	{
		Write-Error "Cannot find $strGreenSphereRTPat" -ErrorAction Stop
	} else {
		$Global:GreenSphereRT = ExtractFrom-ImagePackage -Path $strGreenSphereRTPath -Name "GreenSphere-App (real-time)"
	}
	if( -not (Test-Path -Path $strBlueSphereRTPath) )	{
		Write-Error "Cannot find $strBlueSphereRTPath" -ErrorAction Stop
	} else {
		$Global:BlueSphereRT = ExtractFrom-ImagePackage -Path $strBlueSphereRTPath -Name "BlueSphere-App (real-time)"
	}
}


Check-Prerequisites
