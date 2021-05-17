
Import-Module -Name AzSphereCli

# relative paths of imagepackages to the OTA sample (under the proviso being built for Debug)
$strIoTConnectHLPath = ".\\IoTConnectHL\\out\\ARM-Debug\\IoTConnectHL.imagepackage"
$strRedSphereRTPath = ".\\RedSphereRT\\out\\ARM-Debug\\RedSphereRT.imagepackage"
$strGreenSphereRTPath = ".\\GreenSphereRT\\out\\ARM-Debug\\GreenSphereRT.imagepackage"
$strBlueSphereRTPath = ".\\BlueSphereRT\\out\\ARM-Debug\\BlueSphereRT.imagepackage"

$strRedSphereProduct = "RedSphere Product"
$strGreenSphereProduct = "GreenSphere Product"
$strBlueSphereProduct = "BlueSphere Product"

Enum Roles {
    Administrator
    Contributor
    Reader
}

# .SYNOPSIS ImagePackage structure with Component Name, ComponentID, ImageID and FilePath
Class Tenant
{
    [String] $Id
    [String] $Name
    [Roles[]] $Roles

    #public constructor
    Tenant()
    {
        
    }

}


# .SYNOPSIS ImagePackage structure with Component Name, ComponentID, ImageID and FilePath
Class ImagePackage
{
    [String] $Name
    [Guid] $ComponentID
    [Guid] $ImageID
    [String] $FilePath

    #public constructor with file path to ImagePackage
    ImagePackage([String] $FilePath)
    {
        $this.FilePath = $FilePath
    }

}

# <# ImagePackage structure for IoTConnectHL POSIX application #>
# [ImagePackage] $IoTConnectHL  = $null
# <# ImagePackage structure for RedSphereRT real-time application #>
# [ImagePackage] $RedSphereRT   = $null
# <# ImagePackage structure for GreenSphereRT real-time application #>
# [ImagePackage] $GreenSphereRT = $null
# <# ImagePackage structure for BlueSphereRT real-time application #>
# [ImagePackage] $BlueSphereRT  = $null



class AS3EntityBase
{
<#
.SYNOPSIS
Entity base class with Id, Name, Description
#>

    # public properties
    [Guid] $Id
    [String] $Name
    [String] $Description

    # public empty constructor
    AS3EntityBase(){}

    # public full constructor
    AS3EntityBase(
        [String] $IdString,
        [String] $Name,
        [String] $Description
    )
    {
        $this.Id = [Guid]::new($IdString)
        $this.Name = $Name
        $this.Description = $Description
    }

    # public constructor
    AS3EntityBase(
        [String] $IdString,
        [String] $Name
    )
    {
        $this.Id = [Guid]::new($IdString)
        $this.Name = $Name
        $this.Description = ""
    }

    # public override for ToString method
    [string] ToString()
    {
        return $this.Name
    }

    # public IdString method
    [string] IdString()
    {
        return $this.Id.ToString()
    }
}


Class Deployment
{
    [Guid] $Id
    [DateTime] $DeploymentDateUTC
    [Guid[]] $DeployedImages

    Deployment(){}

    Deployment(
        [String] $IdString,
        [String] $Timestamp
    )
    {
        $this.Id = [Guid]::new( $IdString )
        $this.DeploymentDateUTC = [DateTime]::Parse($Timestamp)

    }
    Deployment(
        [String] $IdString,
        [String] $Timestamp,
        [String] $Images
    )
    {
        $this.Id = [Guid]::new( $IdString )
        $this.DeploymentDateUTC = [DateTime]::Parse($Timestamp)
        $img = $Images.Substring(1,$Images.Length-2) #remove "[]"
        $imgLst = $img.Replace(", ", ",").Split(",") #get rid of ", " spaces
        $this.DeployedImages = $imgLst.ForEach( {  return  [Guid]::new($_) } )
    }

	[string] ToString()
    {
        return $this.Id.ToString()
    }
}

Enum OsFeedType
{
<#
.SYNOPSIS
OsFeedType enumeration with Retail and RetailEval members
#>
    Retail
    RetailEval
}

Enum ApplicationUpdatePolicy
{
<#
.SYNOPSIS
ApplicationUpdatePolicy enumeration with On (allows OTA application updates) and Off (allows only OS updates) members
#>
    On
    Off
}




Class DeviceGroup : AS3EntityBase
{
<#
.SYNOPSIS
DeviceGroup class with Id, Name, Description, OS Feed Type and UpdatePolicy
#>

    # public properties
    [OsFeedType] $OsFeed = [OsFeedType]::RetailEval
    [ApplicationUpdatePolicy] $ApplicationUpdate = [ApplicationUpdatePolicy]::On
    [Deployment] $CurrentDeployment = $null
    [HashTable] $Deployments = $null

    # public constructor
    DeviceGroup(
        [String] $IdString,
        [String] $Name
    ) : base($IdString, $Name){ }

    # public constructor
    DeviceGroup(
        [String] $Id,
        [String] $Name,
        [String] $Description
    ) : base($Id, $Name, $Description){ }

}




Class Product  : AS3EntityBase
{
<#
.SYNOPSIS
Product class with Id, Name, Description properties; public constructors and ToString overrides
#>

    # public properties
    [HashTable] $DeviceGroupList = $null

    # public empty constructor
    Product() : base(){}

    # public full constructor
    Product(
        [String] $IdString,
        [String] $Name,
        [String] $Description
    ) : base($IdString, $Name, $Description ){ }

}

[Tenant[]] $Tenants = $null
[Tenant] $SelectedTenant = $null

[Product] $RedSphereProduct = $null
[Product] $GreenSphereProduct = $null
[Product] $BlueSphereProduct = $null


<#
.SYNOPSIS
Extracts ComponentID, ImageID from given imagepackage file.
.DESCRIPTION
Creates CustomPSObject of type ImagePackage with Name, ComponentID, ImageID & FilePath properties from
given imagepackage file.
.PARAMETER Path
Specifies the path to the .imagepackage file
.INPUTS
None. You cannot pipe objects to Get-ImagePackageFile.
.OUTPUTS
ImagePackage structure containing Name, ComponentID, ImageID, FilePath
.EXAMPLE
PS> Get-ImagePackageFile -path "./RedSphereRT.imagepackage"
Name ComponentID                          ImageID                              FilePath
---- -----------                          -------                              --------
Test f4e25978-6152-447b-a2a1-64577582f327 1b45e9b9-d339-4905-89c1-2a0ecf16f665 .\RedSphereRT.imagepackage
#>
function Get-ImagePackageFile(
    [cmdletbinding()]
	[Parameter(Mandatory=$true, Position=0)] [Alias("f")]  [string] $Path)
{
    if( (Test-Path -Path $path ) -and ([System.IO.Path]::GetExtension($path) -eq ".imagepackage"))
    {
        $app = [ImagePackage]::new( $Path )

        $result = & azsphere image-package show -f "$($app.FilePath)"
        if( $LASTEXITCODE -eq 0 )
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
        Write-Host "Found '$($app.Name)' with ImageId $($app.ImageID.ToString())"
        return $app
    } else {
        Write-Error "Unable to find imagepackage '$Path'" -ErrorAction Stop
    }
}


<#
.SYNOPSIS
Retrieves the current list of Products
.DESCRIPTION
Retrieves the current list of Products
.INPUTS
None. You cannot pipe objects to Get-AS3Products.
.OUTPUTS
[Hashtable] of Key:ProductName, Value:Guid
.EXAMPLE
PS> Get-AS3Products
Name                           Value
----                           -----
CM300                          1124894e-79c2-4278-b3f2-c11563c14b2b
RedSphere Product              48bc4d96-a2e9-4a3d-8ce7-db06996666f2
#>
function Get-AS3Products()
{
[cmdletbinding()]
param()

	$result = azsphere product list
    if( $LASTEXITCODE -eq 0 )
    {
        Write-Verbose "[Get-AS3Products] $($result[0])"
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-3 )
        [System.Array]::Copy($result,3, $lst, 0, $result.Length-3)

        [HashTable] $tblProducts = [HashTable]::new( $lst.Length ) #@{}
        $lst.ForEach( {
                $tblProducts.Add( $_.Substring(37,$_.Length-37).Trim(), # Extract name from line
                                  [Guid]::new( $_.Substring(0,36) ) ) # extract Guid string from line and convert to [GUID]
        } )
        Write-Verbose "[Get-AS3Products] extracted $($tblProducts.Count) products"
        return $tblProducts
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Retrieves the current list of DeviceGroups for a product
.DESCRIPTION
Retrieves the current list of DeviceGroups for a product
.INPUTS
None. You cannot pipe objects to Get-AS3Products.
.OUTPUTS
[Hashtable] of Key:DeviceGroupName, Value:Guid
.EXAMPLE
PS> Get-AS3ProductDeviceGroups
Name                           Value
----                           -----
CM300                          1124894e-79c2-4278-b3f2-c11563c14b2b
RedSphere Product              48bc4d96-a2e9-4a3d-8ce7-db06996666f2
#>
function Get-AS3ProductDeviceGroups(
    [cmdletbinding()]
    [Parameter(Mandatory=$true, Position=0, HelpMessage="Retrieve DeviceGroups for given product.")]
	[Alias("i")] [Guid] $ProductId
)
{

	$result = & azsphere prd dg list -i $ProductId.ToString()
    if( $LASTEXITCODE -eq 0 )
    {
        Write-Verbose "[Get-AS3ProductDeviceGroups] $($result[1])"
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-4 )
        [System.Array]::Copy($result,4, $lst, 0, $result.Length-4)

        [HashTable] $tblDGs = [HashTable]::new( $lst.Length ) #@{}
        $lst.ForEach( {
                $tblDGs.Add( $_.Substring(37,$_.Length-37).Trim(), # Extract name from line
                                  [Guid]::new( $_.Substring(0,36) ) ) # extract Guid string from line and convert to [GUID]
        } )
        Write-Verbose "[Get-AS3ProductDeviceGroups] extracted $($tblDGs.Count) device groups."
        return $tblDGs
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}


<#
.SYNOPSIS
Searches for a Product in Azure Sphere Security Service by product name or by product id
.DESCRIPTION
Finds a SKU in Azure Sphere Security Service with the given ProductName or ProductId and returns the [Product]
.PARAMETER Name
Specifies the name for the SKU.
.PARAMETER ProductName
[String] Name of product to find
.PARAMETER ProductId
[Guid] Id of product to retrieve
.INPUTS
None. You cannot pipe objects to Get-AS3Product.
.OUTPUTS
[Product] Product object
.EXAMPLE
PS> Get-AS3Product -Name "Test-SKU"
Id                                   Name     Description
--                                   ----     -------
f7c7a7d9-f890-4293-abe6-f15f7436006f Test-SKU Test product
#>
function Get-AS3Product(
    [cmdletbinding( DefaultParameterSetName='ById' )]
	[Parameter(ParameterSetName='ByName', Mandatory=$false)]
    [Parameter(ParameterSetName='ByID', Mandatory=$true, Position=0)]
    [Parameter(HelpMessage="Search for product by product id.")]
	[Alias("i")] [Guid] $ProductId,

	[Parameter(ParameterSetName='ByName', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='ByID', Mandatory=$false)]
    [Parameter(HelpMessage="Search for product by product name.")]
	[Alias("n")] [string] $ProductName
)
{

    [Product] $product = $null


    if( $PSCmdlet.ParameterSetName -eq "ByName")
    {
        Write-Verbose "[Get-AS3Product] Searching online for product name '$ProductName'."
        $result = & azsphere.exe product show -n $ProductName
    } else
    {
        Write-Verbose "[Get-AS3Product] Searching online for product id '$ProductId'."
        $result = & azsphere.exe product show -i $ProductId
    }
    if( $LASTEXITCODE -eq 0 )
    {
        $product = [Product]::new(
            [Guid]::new($result[2].Substring(16,$result[2].Length-16)),
            $result[3].Substring(17,$result[3].Length-18),
            $result[4].Substring(17,$result[4].Length-18)
        )
    }

    if( $null -eq $product )
    {
        if( $PSCmdlet.ParameterSetName -eq "ByName")
        {
	        Write-Error "Product with Name '$ProductName' not found."
        } else
        {
	        Write-Error "Product with Id '$ProductId' not found."
        }
    }
    return $product
}


<#dir
.SYNOPSIS
Creates a new Product in Azure Sphere Security Service
.DESCRIPTION
Creates a new Product in Azure Sphere Security Service with the given Name and returns the Guid of the newly created ProductSKU
.PARAMETER Name
Specifies the name for the new ProductSKU.
.INPUTS
None. You cannot pipe objects to New-AS3Product.
.OUTPUTS
[System.Guid] ProductId
.EXAMPLE
PS> New-AS3Product -Name "TestProduct" [-Description "What this product is about"]
Guid
-----------
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3Product(
    [cmdletbinding()]
	[Parameter(Mandatory=$true)]  [Alias("n")] [string] $Name,
	[Parameter(Mandatory=$false)] [Alias("d")] [string] $Description=""
)
{
    Write-Verbose "[New-AS3Product] Creating product '$Name'"
	$result = & azsphere product create -n "$Name" -d "$Description"
    if( $LASTEXITCODE -eq 0 )
    {
        Write-Verbose "[New-AS3Product] $result[0]"
        [Product] $prd = Get-AS3Product -ProductName "$Name"
        $prd.DeviceGroupList = Get-AS3ProductDeviceGroups -ProductId $prd.Id

        Write-Verbose "[New-AS3Product] product $Name has id $($prd.Id)"
		return $prd
    } else {
        Write-Error $result -ErrorAction Stop
	}
}





<#
.SYNOPSIS
Creates a new DeviceGroup in Azure Sphere Security Service
.DESCRIPTION
Creates a device group with the specified name for the specified product. The device group organizes devices
that have the same product and receive the same applications from the cloud.
.PRAMETER Name
Specifies an alphanumeric name for the device group. If the name includes embedded spaces, enclose it in quotation marks. The device group name must be unique within the product, and is case insensitive.
.PRAMETER Description
Optional text to describe the Device Group. Can be empty.")]
.PRAMETER ProductId
The tenant-unique name of the product for which to create a device group. Either -ProductName or -ProductId is required.
.PRAMETER ProductName
The tenant-unique name of the product for which to create a device group. Either -ProductName or -ProductId is required.
.PRAMETER ApplicationUpdate
Disables or enables application updates for this device group. This is a binary option: On means that application updates are enabled, Off indicates application updates are disabled. Default is On.
.PRAMETER OsFeed
This is an enum value: Retail, RetailEval. Default is Retail.
.INPUTS
None. You cannot pipe objects to New-AS3DeviceGroup.
.OUTPUTS
[System.Guid] DeviceGroupId for consistency reasons
.EXAMPLE
PS> New-AS3ProductDeviceGroup -Name "TestDeviceGroup"
Guid
-----------
f4e25978-6152-447b-a2a1-64577582f327
#>
function New-AS3ProductDeviceGroup()
{
    param(
    [cmdletbinding( DefaultParameterSetName='ByName' )]
	[Parameter(ParameterSetName='ByName', Mandatory=$true)]
    [Parameter(ParameterSetName='ByID', Mandatory=$true)]
	[Parameter(HelpMessage="Specifies an alphanumeric name for the device group. If the name includes embedded spaces, enclose it in quotation marks. The device group name must be unique within the product, and is case insensitive.")]
    [Alias("n")]
    [string] $Name,

	[Parameter(ParameterSetName='ByName', Mandatory=$false)]
    [Parameter(ParameterSetName='ByID', Mandatory=$false)]
	[Parameter(HelpMessage="Optional text to describe the Device Group. Can be empty.")]
    [Alias("d")]
    [string] $Description = "",

	[Parameter(ParameterSetName='ByName', Mandatory=$true)]
	[Parameter(HelpMessage="Specifies an alphanumeric name for the device group. The device group name must be unique within the product, and is case insensitive.")]
    [Alias("pn")]
    [string] $ProductName,

	[Parameter(ParameterSetName='ByID', Mandatory=$true)]
	[Parameter(HelpMessage="The tenant-unique name of the product for which to create a device group. Either --productname or --productid is required.")]
    [Alias("pi")]
    [string] $ProductId,

	[Parameter(ParameterSetName='ByName', Mandatory=$false)]
    [Parameter(ParameterSetName='ByID', Mandatory=$false)]
	[Parameter(HelpMessage="Disables or enables application updates for this device group. This is a binary option: On means that application updates are enabled, Off indicates application updates are disabled. Default is On.")]
    [Alias("a")]
    [ApplicationUpdateType] $ApplicationUpdate = [ApplicationUpdateType]::On,

	[Parameter(ParameterSetName='ByName', Mandatory=$false)]
    [Parameter(ParameterSetName='ByID', Mandatory=$false)]
	[Parameter(HelpMessage="This is an enum value: Retail, RetailEval. Default is Retail.")]
    [Alias("o")]
    [OsFeedType] $OsFeed = [OsFeedType]::Retail
    )

    if( $PSCmdlet.ParameterSetName -eq "ById")
    {
	    $result = azsphere dg create -n "$Name" -d "$Description" -pi $ProductId -a $ApplicationUpdate.ToString() -o $OsFeed.ToString()
    } else {
	    $result = azsphere dg create -n "$Name" -d "$Description" -pn $ProductName -a $ApplicationUpdate.ToString() -o $OsFeed.ToString()
    }
    if( $? -eq $true )
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
Retrieves the deployments of the given device-group
.DESCRIPTION
Get-AS3DeploymentList retrieves the list of deployments for a specific device-group
.PRAMETER DeviceGroupId
[Guid] for the device group.
.INPUTS
None. You cannot pipe objects to Get-AS3DeploymentList.
.OUTPUTS
[Deployment[]] array of deployments
.EXAMPLE
PS> Get-AS3DeploymentList -i "guid"
Id                                   DeploymentDateUTC   DeployedImages
--                                   -----------------   --------------
a12b86c9-eb1d-4e87-a3e8-e86b7e4f4818 03.01.2020 14:34:22 {f1c5d8dd-16e6-499b-9a6d-b7fd828ee48e}
#>
function Get-AS3DeploymentList(
    [cmdletbinding()]
    [Parameter(Mandatory=$true, Position=0, HelpMessage="Retrieve list of deployments for given device-group.")]
	[Alias("i")] [Guid] $DeviceGroupId
)
{

    Write-Verbose "[Get-AS3DeploymentList] for Id $($DeviceGroupId.ToString())"
	$result = & azsphere dg dep list -i $DeviceGroupId.ToString()

    if( $LASTEXITCODE -eq 0 )
    {
        Write-Verbose "[Get-AS3DeploymentList] $($result[1])"
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-4 )
        [System.Array]::Copy($result,4, $lst, 0, $result.Length-4)
        [Deployment[]] $tblDeps = $lst.ForEach( {
            [Deployment]::new(
                $_.Substring(0,36), # extract Guid from line
                $_.Substring(37,19), # extract timestamp from line
                $_.Substring(57).TrimEnd() # extract image list
            )
        } )
        Write-Verbose "[Get-AS3DeploymentList] extracted $($tblDeps.Count) deployments: $($tblDeps -join ', ')"
        return $tblDeps
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}


<#
.SYNOPSIS
Creates a new Deployment for the given device-group
.DESCRIPTION
New-AS3Deployment creates a new deployment for a specific device-group
.PRAMETER DeviceGroupId
[Guid] for the device group.
.PRAMETER Images
[Guid] or [Guid[]] one or more image ids.
.INPUTS
None. You cannot pipe objects to New-AS3Deployment.
.OUTPUTS
[Deployment] the newly created deployment
.EXAMPLE
PS> New-AS3Deployment -i "guid" -ii (guid,guid)
Id                                   DeploymentDateUTC   DeployedImages
--                                   -----------------   --------------
b639cb10-63f1-4f6e-ad76-35a4533ff546 24.01.2020 13:44:58 {9337f63a-19de-4fd4-aaba-d754bdeb1cad, 3e434151-c30f-4b72-99cd-d3db77d80760}
#>
function New-AS3Deployment(
    [cmdletbinding()]
    [Parameter(Mandatory=$true, Position=0, HelpMessage="The device-group guid.")]
	[Alias("i")] [Guid] $DeviceGroupId,
    [Parameter(Mandatory=$true, Position=0, HelpMessage="one or more image IDs")]
	[Alias("ii")] $Images
)
{

    Write-Verbose "[New-AS3Deployment] for device-group $($DeviceGroupId.ToString())"

    if( $Images -is [System.Array])
    {
        $imgIDs = [System.String]::Join(",", $Images)

    } else {
        $imgIDs = $Images
    }

	$result = & azsphere dg dep create -i $DeviceGroupId.ToString() -ii $imgIDs

    if( $LASTEXITCODE -eq 0 )
    {
        [Deployment[]] $tblDeps = Get-AS3DeploymentList -i $DeviceGroupId.ToString()
        Write-Verbose "[New-AS3Deployment] Deployment $($tblDeps[0].Id) created $($tblDeps[0].DeploymentDateUTC) with images [$($tblDeps[0].DeployedImages -join ', ')]"
        return $tblDeps[0]
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Get-AS3DeviceGroup retrieves the device-group data for the given devive-group id
.DESCRIPTION
Get-AS3DeviceGroup retrieves the device-group data for the given devive-group id
.PRAMETER DeviceGroupId
[Guid] for the device group.
.INPUTS
None. You cannot pipe objects to Get-AS3DeviceGroup.
.OUTPUTS
[Deployment[]] array of deployments
.EXAMPLE
PS> Get-AS3DeploymentList -i "guid"
Id                                   DeploymentDateUTC   DeployedImages
--                                   -----------------   --------------
a12b86c9-eb1d-4e87-a3e8-e86b7e4f4818 03.01.2020 14:34:22 {f1c5d8dd-16e6-499b-9a6d-b7fd828ee48e}
#>
function Get-AS3DeviceGroup(
    [cmdletbinding()]
    [Parameter(Mandatory=$true, Position=0, HelpMessage="Retrieve DeviceGroup details.")]
	[Alias("i")] [Guid] $DeviceGroupId
)
{

    Write-Verbose "[Get-AS3DeviceGroup] Retrieving for Id $($DeviceGroupId.ToString())"
	$result = & azsphere dg show -i $DeviceGroupId.ToString()

    if( $LASTEXITCODE -eq 0 )
    {
        [DeviceGroup] $dg = [DeviceGroup]::new(
            $result[2].Split("'").Item(1),
            $result[3].Split("'").Item(1),
            $result[4].Split("'").Item(1)
            )
        Write-Verbose "[Get-AS3DeviceGroup] Name: '$($dg.Name)'"

        $dg.OsFeed = [OsFeedType]::Parse( [OsFeedType], $result[5].Split("'").Item(1));
        if( $result[6].Split(":").Item(1).Contains("Accept all updates") )
        {
            $dg.ApplicationUpdate = [ApplicationUpdatePolicy]::On
        } else {
            $dg.ApplicationUpdate = [ApplicationUpdatePolicy]::Off
        }
        if( -not $result[7].Contains("None") )
        {
            [string] $strCurrentDeployment = $result[8].Split("'").Item(1)
            Write-Verbose "[Get-AS3DeviceGroup] Current Deployment Id $strCurrentDeployment"
            [Deployment[]] $lstDeps = Get-AS3DeploymentList -i $DeviceGroupId.ToString()
            [HashTable] $tblDeps = [HashTable]::new( $lstDeps.Length ) #@{}
            $lstDeps.ForEach( {
                $tblDeps.Add(
                    $_.Id.ToString(), # ImageId string as key
                    $_                # [Deployment] as value
                )
            } )
            [Deployment] $dep = $tblDeps[$strCurrentDeployment]
            $dg.CurrentDeployment = $dep
            Write-Verbose "[Get-AS3DeviceGroup] Current Deployment: $($dep.Id.ToString()) created $($dep.DeploymentDateUTC.ToLongDateString()) $($dep.DeploymentDateUTC.ToLongTimeString())"

        } else {
            Write-Verbose $result[7]
        }

        return $dg
    } else {
		Write-Error $result[0] -ErrorAction Stop
	}
}

<#
.SYNOPSIS
Uploads a new ImagePackage file into an Azure Sphere Security Service
.DESCRIPTION
Uploads a new ImagePackage file into an Azure Sphere Security Service
.PARAMETER FilePath
Specifies the path to the .imagepackage file
.INPUTS
None. You cannot pipe objects to Add-AS3Image.
.OUTPUTS
[System.Guid] ImageId of the uploaded .imagepackage-file
.EXAMPLE
PS> Add-AS3Image -FilePath ./testfile.imagepackage
Guid
-----------
f4e25978-6152-447b-a2a1-64577582f327
#>
function Add-AS3Image(
    [cmdletbinding()]
	[Parameter(Mandatory=$true, Position=0)] [Alias("f")] $FilePath
)
{
    Write-Verbose "[Add-AS3Image] Uploading file $FilePath..."

	$result = & azsphere img add -f "$FilePath" --force
    if( $LASTEXITCODE -eq 0 )
    {
        [String] $s = $result[ $result.Length-2 ]
        Write-Verbose "[Add-AS3Image] Id $s"
		return $s
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
Set-SdkPaths queries the Windows registry for the Azure Sphere SDK entries and sets the paths accordingly.
.DESCRIPTION
Set-SdkPaths queries the Windows registry for the Azure Sphere SDK entries and sets the path to the azsphere.exe tool
.INPUTS
None. You cannot pipe objects to Initialize-Prerequisites.
.OUTPUTS
Nothing
.EXAMPLE
PS> Initialize-Prerequisites

#>
function Set-SdkPaths()
{
    [cmdletbinding()]
    param()

    $SdkPath = (Get-ItemProperty -Path "HKLM:SOFTWARE\WOW6432Node\Microsoft\Azure Sphere").InstallDir
    $SdkToolsPath = Join-Path -Path $SdkPath -ChildPath "Tools"
    $Latest = (Get-ChildItem "HKLM:SOFTWARE\WOW6432Node\Microsoft\Azure Sphere\Sysroots")[-1].GetValue("InstallDir")
    $gccPath = Join-Path -Path $Latest -ChildPath "tools\gcc"
    if( -not $Env:Path.Contains( $SdkPath ) )
    {
        Write-Verbose "[Set-Location] SDK path is $SdkPath"
        $Env:Path = $SdkPath + ";" + $Env:Path
    }
    if( -not $Env:Path.Contains( $SdkToolsPath ) )
    {
        Write-Verbose "[Set-Location] SDK tools path is $SdkToolsPath"
        $Env:Path = $SdkToolsPath + ";" + $Env:Path
    }
    if( -not $Env:Path.Contains( $gccPath ) )
    {
        Write-Verbose "[Set-Location] GNU gcc path is $gccPath"
        $Env:Path = $gccPath + ";" + $Env:Path
    }
    if( (Get-Location).Path.Contains("AS3Scripts") )
    {
        Write-Verbose "[Set-Location] adjusting current directory to root of OTA sample"
        Set-Location ..
    }

#    $Help = @(( "dev, device"    , "Manage devices."                                                            ), `
#    ( "dg, device-group"         , "Manage device groups in your Azure Sphere tenant."                          ), `
#    ( "get-support-data"         , "Gather diagnostic data about your system, cloud and device configurations." ), `
#    ( "hwd, hardware-definition" , "Manage hardware definitions."                                               ), `
#    ( "img, image"               , "Manage images in your Azure Sphere tenant."                                 ), `
#    ( "pkg, image-package"       , "Manage image packaging."                                                    ), `
#    ( "login"                    , "Log in to the Azure Sphere Security Service."                               ), `
#    ( "logout"                   , "Log out from the Azure Sphere Security Service."                            ), `
#    ( "prd, product"             , "Manage products in your Azure Sphere tenant."                               ), `
#    ( "register-user"            , "Register a new user to the Azure Sphere Security Service."                  ), `
#   ( "role"                     , "Manage Azure Sphere roles."                                                 ), `
#   ( "show-user"                , "Show information about the logged in Azure Sphere user."                    ), `
#    ( "show-version"             , "Show the version of the Azure Sphere tools."                                ), `
#    ( "tenant"                   , "Manage Azure Sphere tenants."                                               ))
#
#    Write-Host "azsphere -?" -ForegroundColor Green
#
#    ForEach($ln in $Help){
#        Write-Host $ln[0] ( " " * (24-$ln[0].Length)) -ForegroundColor Yellow -NoNewline
#        Write-Host "- " $ln[1] -ForegroundColor Green
#    }
    
    &azsphere

    Write-Host "azsphere tenant list" -ForegroundColor Cyan
    $Tenants = &azsphere tenant list -o json | ConvertFrom-Json
    Format-Table -InputObject $Tenants

    Write-Host "azsphere tenant show-selected" -ForegroundColor Cyan
    $SelectedTenant = &azsphere tenant show-selected -o json | ConvertFrom-Json
    Format-Table -InputObject $SelectedTenant

    Write-Host "azsphere show-user" -ForegroundColor Cyan
    &azsphere show-User --output json --query "name"

}

<#
.SYNOPSIS
Initializes prerequisites.
.DESCRIPTION
Initializes the global variables needed for the OTA sample in the Azure Sphere Train-the-trainer Bootcamp
.INPUTS
None. You cannot pipe objects to Initialize-Prerequisites.
.OUTPUTS
Nothing
.EXAMPLE
PS> Initialize-Prerequisites

#>
function Initialize-Prerequisites()
{
[cmdletbinding()]
param()

    Write-Host "`nChecking for image-packages in directory tree...."
	if( -not (Test-Path -Path $strIoTConnectHLPath) )	{
        Write-Warning "Cannot find $strIoTConnectHLPath.`nPlease check that you have built IoTConnectHL as ""ARM-Debug"" version." -WarningAction Stop
	} else {
        $Global:IoTConnectHL = Get-ImagePackageFile -Path $strIoTConnectHLPath
        Write-Verbose "'$strIoTConnectHLPath' has image id $($Global:IoTConnectHL.ImageId)"
	}
	if( -not (Test-Path -Path $strRedSphereRTPath) )	{
        Write-Warning "Cannot find $strRedSphereRTPath.`nPlease check that you have built RedSphereRT as ""ARM-Debug"" version." -WarningAction Stop
	} else {
		$Global:RedSphereRT = Get-ImagePackageFile -Path $strRedSphereRTPath
        Write-Verbose "'$strRedSphereRTPath' has image id $($Global:RedSphereRT.ImageId)"
	}
	if( -not (Test-Path -Path $strGreenSphereRTPath) )	{
        Write-Warning "Cannot find $strGreenSphereRTPath.`nPlease check that you have built GreenSphereRT as ""ARM-Debug"" version." -WarningAction Stop
	} else {
		$Global:GreenSphereRT = Get-ImagePackageFile -Path $strGreenSphereRTPath
        Write-Verbose "'$strGreenSphereRTPath' has image id $($Global:GreenSphereRT.ImageId)"
	}
	if( -not (Test-Path -Path $strBlueSphereRTPath) )	{
        Write-Warning "Cannot find $strBlueSphereRTPath.`nPlease check that you have built BlueSphereRT as ""ARM-Debug"" version." -WarningAction Stop
	} else {
        $Global:BlueSphereRT = Get-ImagePackageFile -Path $strBlueSphereRTPath
        Write-Verbose "'$strBlueSphereRTPath' has image id $($Global:BlueSphereRT.ImageId)"
	}


    Write-Host "`nChecking for products already available in Azure Sphere Security Service...."
    [HashTable] $tblProducts = Get-AS3Products

    if( $tblProducts.ContainsKey( $strRedSphereProduct ) )
    {
        Write-Host "Found product '$strRedSphereProduct', retrieving additional data..."
        $Global:RedSphereProduct = Get-AS3Product -ProductId $tblProducts[ $strRedSphereProduct ]
        $Global:RedSphereProduct.DeviceGroupList = Get-AS3ProductDeviceGroups -ProductId $tblProducts[ $strRedSphereProduct ]
    } else {
        Write-Warning "Cannot find product '$strRedSphereProduct': follow the OTA sample steps to create the product..."
    }

    if( $tblProducts.ContainsKey( $strGreenSphereProduct ) )
    {
        Write-Host "Found product '$strGreenSphereProduct', retrieving additional data..."
        $Global:GreenSphereProduct = Get-AS3Product -ProductId $tblProducts[ $strGreenSphereProduct ]
        $Global:GreenSphereProduct.DeviceGroupList = Get-AS3ProductDeviceGroups -ProductId $tblProducts[ $strGreenSphereProduct ]
    } else {
        Write-Warning "Cannot find product '$strGreenSphereProduct': follow the OTA sample steps to create the product..."
    }

    if( $tblProducts.ContainsKey( $strBlueSphereProduct ) )
    {
        Write-Host "Found product '$strBlueSphereProduct', retrieving additional data..."
        $Global:BlueSphereProduct = Get-AS3Product -ProductId $tblProducts[ $strBlueSphereProduct ]
        $Global:BlueSphereProduct.DeviceGroupList = Get-AS3ProductDeviceGroups -ProductId $tblProducts[ $strBlueSphereProduct ]
    } else {
        Write-Warning "Cannot find product '$strBlueSphereProduct': follow the OTA sample steps to create the product..."
    }


}
Export-ModuleMember -Function Initialize-Prerequisites
Export-ModuleMember -Function Set-SdkPaths
Export-ModuleMember -Function Add-AS3Image
Export-ModuleMember -Function Get-ImagePackageFile
Export-ModuleMember -Function Get-AS3Products
Export-ModuleMember -Function Get-AS3ProductDeviceGroups
Export-ModuleMember -Function Get-AS3Product
Export-ModuleMember -Function New-AS3Product
Export-ModuleMember -Function New-AS3ProductDeviceGroup
Export-ModuleMember -Function Get-AS3DeploymentList
Export-ModuleMember -Function New-AS3Deployment
Export-ModuleMember -Function Get-AS3DeviceGroup
Export-ModuleMember -Function Add-AS3Image

#$env:Path = "C:\Program Files (x86)\Microsoft Azure Sphere SDK\Tools" + ";" + $Env:Path
#Initialize-Prerequisites -Verbose
#Get-AS3DeviceGroup -DeviceGroupId 6218460f-143e-4467-a5c7-ba2b026cee62 -Verbose


