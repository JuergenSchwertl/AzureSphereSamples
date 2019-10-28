
# relative paths of imagepackages to the OTA sample (under the proviso being built for Debug)
$strIoTConnectHLPath = ".\\IoTConnectHL\\out\\ARM-Debug-3+Beta1909\\IoTConnectHL.imagepackage"
$strRedSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\RedSphereRT\\RedSphereRT.imagepackage"
$strGreenSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\GreenSphereRT\\GreenSphereRT.imagepackage"
$strBlueSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\BlueSphereRT\\BlueSphereRT.imagepackage"

# .SYNOPSIS AppInfo structure with Component Name, ComponentID, ImageID and FilePath
Class AppInfo
{
    [String] $Name
    [Guid] $ComponentID
    [Guid] $ImageID
    [String] $FilePath
}

<# AppInfo structure for IoTConnectHL POSIX application #>
[AppInfo] $IoTConnectHL  = $null
<# AppInfo structure for RedSphereRT real-time application #>
[AppInfo] $RedSphereRT   = $null
<# AppInfo structure for GreenSphereRT real-time application #>
[AppInfo] $GreenSphereRT = $null
<# AppInfo structure for BlueSphereRT real-time application #>
[AppInfo] $BlueSphereRT  = $null

Enum SkuEnum 
{
    Chip
    Product
}


Class SkuEntry
{
    [Guid] $Id
    [String] $Name
    [SkuEnum] $SkuType
}


<#
.SYNOPSIS
Checks if the supplied command output indicates success (last line starts with "Command completed successfully")
.DESCRIPTION
Checks if the supplied command output indicates success (last line starts with "Command completed successfully")
and optionally checks if the minimum of lines are available
.PARAMETER CmdOutput
[System.Array] of text output of the AzSphere.exe response
.PARAMETER MinLines
(Optional) Minimum number of lines in command output.
.INPUTS
None. You cannot pipe objects to Check-AS3Success.
.OUTPUTS
returns True if AzSphere.exe output indicates success 
#>
function Check-AS3Success( 
	[Parameter(Mandatory=$true, Position=0)]  [object[]]  $CmdOutput, 
	[Parameter(Mandatory=$false, Position=1)] [int] $MinLines=1 )
{
    return (($CmdOutput -is [System.Array]) -and ($CmdOutput.Length -gt $MinLines) -and $CmdOutput[ $CmdOutput.Length-1 ].StartsWith("Command completed successfully"))
}

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

        $result = azsphere image show -f $app.FilePath
        if( Check-AS3Success $result 9 )
        {
            if( $result[3].Contains("Component ID:") )
            {
                $app.ComponentID = [System.Guid]( $result[3].Split(":").Item(1).Trim() )
#                $app.ComponentID = [System.Guid]( $result[3].Split(":").Item(1).Trim() )
            }
            if( $result[4].Contains("Image ID:") )
            {
                $app.ImageID = [System.Guid]( $result[4].Split(":").Item(1).Trim() )
            }
            if( [string]::IsNullOrWhiteSpace($Name) -and $result[9].Contains("Image Name:") )
            {
                $app.Name = $result[9].Split(":").Item(1).Trim()
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
    if( Check-AS3Success $result )
    {
        Write-Host $result[1]
        $imsID = [System.Guid]( $result[1].Split("'").Item(3) )
        $info = azsphere ims show -i $imsID
        Write-Host ($info -join "`r`n")
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
    if( Check-AS3Success $result )
    {
        Write-Host $result[1]
        return $ComponentID
    } else {
		Write-Error $result[1] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Creates a new DeviceGroup in Azure Sphere Security Service
.DESCRIPTION
Creates a new DeviceGroup in Azure Sphere Security Service with the given Name and returns the Guid of the newly created DeviceGroup
.PARAMETER Name
Specifies the name for the new DeviceGroup.
.INPUTS
None. You cannot pipe objects to New-AS3DeviceGroup.
.OUTPUTS
[System.Guid] DeviceGroupId for consistency reasons
.EXAMPLE
PS> New-AS3DeviceGroup -Name "TestDeviceGroup"
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3DeviceGroup(
	[Parameter(Mandatory=$true)][string] $Name
)
{
	$result = azsphere dg create -n $Name
    if( Check-AS3Success $result )
    {
        [String] $s = $result[ 1 ]
        Write-Host $s
		return [System.Guid]( $s.Split("'").Item(3) )
    } else {
		Write-Error $result[1] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Searches for a DeviceGroup in Azure Sphere Security Service by name
.DESCRIPTION
Finds a DeviceGroup in Azure Sphere Security Service with the given Name and returns the Guid of the DeviceGroup
.PARAMETER Name
Specifies the name for the new DeviceGroup.
.INPUTS
None. You cannot pipe objects to Find-AS3DeviceGroup.
.OUTPUTS
[System.Guid] DeviceGroupId
.EXAMPLE
PS> Find-AS3DeviceGroup -Name "TestDeviceGroup"
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function Find-AS3DeviceGroup(
	[Parameter(Mandatory=$true)][string] $Name
)
{
	$result = azsphere dg list
    if( Check-AS3Success $result )
    {
        foreach($l in $result)
        {
            if( ($l.Length -gt 50 ) -and ($l.StartsWith(" --> [ID: ")) -and ($l.Substring(49, $l.Length-50).CompareTo( $Name ) -eq 0 ) )
            { 
                Write-Host $l
                # extract GUID sub string from " --> [ID: cd037ae5-27ca-4a13-9e3b-2a9d87f9d7bd] 'System Software Only'"
		        return [System.Guid]( $l.Substring(10,36) )
            }
        }
		Write-Warning "DeviceGroup '$Name' not found"
        return $null
    } else {
		Write-Error $result[1] -ErrorAction Stop
	}
}



<#
.SYNOPSIS
Creates a new DeviceGroup in Azure Sphere Security Service
.DESCRIPTION
Creates a new ProductSKU in Azure Sphere Security Service with the given Name and returns the Guid of the newly created ProductSKU
.PARAMETER Name
Specifies the name for the new ProductSKU.
.INPUTS
None. You cannot pipe objects to New-AS3ProductSKU.
.OUTPUTS
[System.Guid] ProductSKUId
.EXAMPLE
PS> New-AS3ProductSKU -Name "TestProduct" [-Description "What this product is about"]
Guid
-----------                          
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3ProductSKU(
	[Parameter(Mandatory=$true)]  [Alias("n")] [string] $Name,
	[Parameter(Mandatory=$false)] [Alias("d")] [string] $Description=""
)
{
	$result = azsphere sku create -n $Name -d $Description
    if( Check-AS3Success $result )
    {
        [String] $s = $result[ 0 ]
        Write-Host $s
		return [System.Guid]( $s.Split("'").Item(3) )
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}


<#
.SYNOPSIS
Retrieves the current list of SKUs
.DESCRIPTION
Retrieves the current list of SKUs
.INPUTS
None. You cannot pipe objects to Find-AS3SKU.
.OUTPUTS
[System.Array] of [SkuEntry]
.EXAMPLE
PS> Get-AS3SKUList
Id                                   Name               SkuType
--                                   ----               -------
0d24af68-c1e6-4d60-ac82-8ba92e09f7e9 MT3620 A1 16MB     Chip
9d606c43-1fad-4990-b207-554a025e0869 MT3620 A0 16MB     Chip
25827902-db08-466d-a8dd-f30a6cb3428a Private Sphere SKU Product
#>
function Get-AS3SKUList()
{

	$result = azsphere sku list
    if( Check-AS3Success $result 8 )
    {
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-7 )
        [System.Array]::Copy($result,5, $lst, 0, $result.Length-7)
        [System.Array] $SkuList = [System.Array]::CreateInstance( [SkuEntry], $result.Length-7 )
        [int] $i=0

        foreach($l in $lst)
        {
            [SkuEntry]$Sku = [SkuEntry]::new()
            # extract GUID sub string from "90c83845-cce1-4f45-abeb-e50a5aa0a854 GreenSphere SKU    Product "
            #                               0                               ->36|37        variable|  ->9|
            $Sku.Id = [System.Guid]($l.Substring(0,36))
            $Sku.Name = $l.Substring(37,$l.Length-45).Trim()
            $Sku.SkuType = [System.Enum]::Parse([SkuEnum], $l.Substring($l.Length-8,8).Trim() )
            $SkuList[$i] = $Sku
            $i = $i+1
        }
        return $SkuList
    } else {
		Write-Error $result[1] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Searches for a SKU in Azure Sphere Security Service by name
.DESCRIPTION
Finds a SKU in Azure Sphere Security Service with the given Name and returns the Guid of the SKU
.PARAMETER Name
Specifies the name for the SKU.
.PARAMETER SkuList
(Optional) supply previously retrieved list of Skus.
.INPUTS
None. You cannot pipe objects to Find-AS3SKU.
.OUTPUTS
[SkuEntry] SKU 
.EXAMPLE
PS> Find-AS3SKU -Name "Test-SKU"
Id                                   Name     SkuType
--                                   ----     -------
f7c7a7d9-f890-4293-abe6-f15f7436006f Test-SKU Product
#>
function Find-AS3SKU(
	[Parameter(Mandatory=$true, Position=0)] [Alias("n")] [string] $Name,
	[Parameter(Mandatory=$false, Position=1)] [Alias("s")] [System.Array] $SkuList=$null
)
{
    if( $SkuList -eq $null )
    {
        $skuList = Get-AS3SKUList
    }
    foreach($sku in $SkuList)
    {
        if( $Name.CompareTo( $sku.Name ) -eq 0)
        {
            return $sku
        }
    }

	Write-Warning "Product SKU '$Name' not found"
    return $null
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
    Write-Host "Uploading $FilePath..."

	$result = azsphere com img add -f $FilePath --force
    if( Check-AS3Success $result 2 )
    {
        [String] $s = $result[ $result.Length-2 ]
        Write-Host $s
		return [System.Guid]( $s.Split("'").Item(1) )
    } else {
        if($result -is [System.Array])
        {
            if($result.Length -gt 6)
            {
        		Write-Error $result[ $result.Length-6 ] -ErrorAction Stop
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


