
# relative paths of imagepackages to the OTA sample (under the proviso being built for Debug)
$strIoTConnectHLPath = ".\\IoTConnectHL\\out\\ARM-Debug-3+Beta1909\\IoTConnectHL.imagepackage"
$strRedSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\RedSphereRT\\RedSphereRT.imagepackage"
$strGreenSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\GreenSphereRT\\GreenSphereRT.imagepackage"
$strBlueSphereRTPath = ".\\out\\ARM-Debug-3+Beta1909\\BlueSphereRT\\BlueSphereRT.imagepackage"

$strRedSphereProduct = "RedSphere Product"
$strGreenSphereProduct = "GreenSphere Product"
$strBlueSphereProduct = "BlueSphere Product"



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

<# ImagePackage structure for IoTConnectHL POSIX application #>
[ImagePackage] $IoTConnectHL  = $null
<# ImagePackage structure for RedSphereRT real-time application #>
[ImagePackage] $RedSphereRT   = $null
<# ImagePackage structure for GreenSphereRT real-time application #>
[ImagePackage] $GreenSphereRT = $null
<# ImagePackage structure for BlueSphereRT real-time application #>
[ImagePackage] $BlueSphereRT  = $null



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
    [System.Array] $Deployments = $null

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
	[DeviceGroup] $Development = $null

    # public empty constructor
    Product() : base(){} 

    # public full constructor
    Product( 
        [String] $IdString,
        [String] $Name,
        [String] $Description
    ) : base($IdString, $Name, $Description ){ }

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

	[string] ToString()
    {
        return $this.Id.ToString()
    }
}



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
None. You cannot pipe objects to ExtractFrom-Image.
.OUTPUTS
ImagePackage structure containing Name, ComponentID, ImageID, FilePath 
.EXAMPLE
PS> ExtractFrom-ImagePackage -path "./RedSphereRT.imagepackage"
Name ComponentID                          ImageID                              FilePath                  
---- -----------                          -------                              --------                  
Test f4e25978-6152-447b-a2a1-64577582f327 1b45e9b9-d339-4905-89c1-2a0ecf16f665 .\RedSphereRT.imagepackage
#>
function ExtractFrom-ImagePackage( 
	[Parameter(Mandatory=$true, Position=0)] [Alias("f")]  [string] $Path)
{
    if( (Test-Path -Path $path ) -and ([System.IO.Path]::GetExtension($path) -eq ".imagepackage"))
    {
        $app = [ImagePackage]::new( $Path )

        $result = & azsphere pkg show -f "$($app.FilePath)"
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

	$result = azsphere product list
    if( $LASTEXITCODE -eq 0 )
    {
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-4 )
        [System.Array]::Copy($result,3, $lst, 0, $result.Length-4)

        [HashTable] $tblProducts = [HashTable]::new( $lst.Length ) #@{}
        $lst.ForEach( { 
                $tblProducts.Add( $_.Substring(37,$_.Length-37).Trim(), # Extract name from line
                                  [Guid]::new( $_.Substring(0,36) ) ) # extract Guid string from line and convert to [GUID]
        } )

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
    [Parameter(Mandatory=$true, Position=0, HelpMessage="Retrieve DeviceGroups for given product.")]
	[Alias("i")] [Guid] $ProductId
)
{

	$result = & azsphere prd dg list -i $ProductId.ToString()
    if( $LASTEXITCODE -eq 0 )
    {
        [System.Array] $lst = [System.Array]::CreateInstance( [object], $result.Length-5 )
        [System.Array]::Copy($result,4, $lst, 0, $result.Length-5)

        [HashTable] $tblDGs = [HashTable]::new( $lst.Length ) #@{}
        $lst.ForEach( { 
                $tblDGs.Add( $_.Substring(37,$_.Length-37).Trim(), # Extract name from line
                                  [Guid]::new( $_.Substring(0,36) ) ) # extract Guid string from line and convert to [GUID]
        } )

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
        Write-Verbose "Searching online for product name '$ProductName'."
        $result = & azsphere.exe product show -n $ProductName
    } else 
    {
        Write-Verbose "Searching online for product id '$ProductId'."
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
        
    if( $product -eq $null )
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
	[Parameter(Mandatory=$true)]  [Alias("n")] [string] $Name,
	[Parameter(Mandatory=$false)] [Alias("d")] [string] $Description=""
)
{
	$result = & azsphere product create -n "$Name" -d "$Description"
    if( $LASTEXITCODE -eq 0 )
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


function Get-AS3DeviceGroup(
    [Parameter(Mandatory=$true, Position=0, HelpMessage="Retrieve DeviceGroup for given product.")]
	[Alias("i")] [Guid] $DeviceGroupId
)
{

	$result = & azsphere dg show -i $DeviceGroupId.ToString()
    if( $LASTEXITCODE -eq 0 )
    {
        [String] $n
        [DeviceGroup] $dg = [DeviceGroup]::new(
            $result[2].Split(":").Item(1).Trim().SubString(1,36),

        )

        return $tblDGs
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
	[Parameter(Mandatory=$true, Position=0)] [Alias("f")] $FilePath
)
{
    Write-Host "Uploading $FilePath..."

	$result = azsphere img add -f $FilePath --force
    if( Check-AS3Success $result 2 )
    {
        [String] $s = $result[ $result.Length-2 ]
        Write-Host $s
		return [System.Guid]::new( $s.Split("'").Item(1) )
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
Creates CustomPSObject of type ImagePackage with Name, ComponentID, ImageID & FilePath properties from 
given imagepackage file.
.INPUTS
None. You cannot pipe objects to ExtractFrom-Image.
.OUTPUTS
ImagePackage structure containing Name, ComponentID, ImageID, FilePath 
.EXAMPLE
PS> Check-Prerequisites


#>
function Check-Prerequisites()
{

    Write-Host "`nChecking for image-packages in directory tree...."
	if( -not (Test-Path -Path $strIoTConnectHLPath) )	{
		Write-Error "Cannot find $strIoTConnectHLPath." -ErrorAction Stop
	} else {
		$Global:IoTConnectHL = ExtractFrom-ImagePackage -Path $strIoTConnectHLPath
	}
	if( -not (Test-Path -Path $strRedSphereRTPath) )	{
		Write-Error "Cannot find $strRedSphereRTPath" -ErrorAction Stop
	} else {
		$Global:RedSphereRT = ExtractFrom-ImagePackage -Path $strRedSphereRTPath
	}
	if( -not (Test-Path -Path $strGreenSphereRTPath) )	{
		Write-Error "Cannot find $strGreenSphereRTPat" -ErrorAction Stop
	} else {
		$Global:GreenSphereRT = ExtractFrom-ImagePackage -Path $strGreenSphereRTPath
	}
	if( -not (Test-Path -Path $strBlueSphereRTPath) )	{
		Write-Error "Cannot find $strBlueSphereRTPath" -ErrorAction Stop
	} else {
		$Global:BlueSphereRT = ExtractFrom-ImagePackage -Path $strBlueSphereRTPath
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
        Write-Host "Found product '$strBluephereProduct', retrieving additional data..."
        $Global:BlueSphereProduct = Get-AS3Product -ProductId $tblProducts[ $strBlueSphereProduct ]
        $Global:BlueSphereProduct.DeviceGroupList = Get-AS3ProductDeviceGroups -ProductId $tblProducts[ $strBlueSphereProduct ]
    } else {
        Write-Warning "Cannot find product '$strBlueSphereProduct': follow the OTA sample steps to create the product..."
    }


}


Check-Prerequisites


