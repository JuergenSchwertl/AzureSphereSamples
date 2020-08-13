# Fancy way to get the last array member is to use negative indices instead of $arr[$arr.Count-1]

$SdkPath = (Get-ItemProperty -Path "HKLM:SOFTWARE\WOW6432Node\Microsoft\Azure Sphere").InstallDir
$SdkToolsPath = Join-Path -Path $SdkPath -ChildPath "Tools"
$Latest = (Get-ChildItem "HKLM:SOFTWARE\WOW6432Node\Microsoft\Azure Sphere\Sysroots")[-1].GetValue("InstallDir")
$gccPath = Join-Path -Path $Latest -ChildPath "tools\gcc"
if( -not $Env:Path.Contains( $SdkPath ) )
{
    Write-Host "Adding Azure Sphere SDK path"
    $Env:Path = $SdkPath + ";" + $Env:Path
}
if( -not $Env:Path.Contains( $SdkToolsPath ) )
{
    Write-Host "Adding Azure Sphere SDK tools path"
    $Env:Path = $SdkToolsPath + ";" + $Env:Path
}
if( -not $Env:Path.Contains( $gccPath ) )
{
    Write-Host "Adding latest GNU gcc tools path"
    $Env:Path = $gccPath + ";" + $Env:Path
}

$Help = @(( "dev, device"    , "Manage devices."                                                            ), `
( "dg, device-group"         , "Manage device groups in your Azure Sphere tenant."                          ), `
( "get-support-data"         , "Gather diagnostic data about your system, cloud and device configurations." ), `
( "hwd, hardware-definition" , "Manage hardware definitions."                                               ), `
( "img, image"               , "Manage images in your Azure Sphere tenant."                                 ), `
( "pkg, image-package"       , "Manage image packaging."                                                    ), `
( "login"                    , "Log in to the Azure Sphere Security Service."                               ), `
( "logout"                   , "Log out from the Azure Sphere Security Service."                            ), `
( "prd, product"             , "Manage products in your Azure Sphere tenant."                               ), `
( "register-user"            , "Register a new user to the Azure Sphere Security Service."                  ), `
( "role"                     , "Manage Azure Sphere roles."                                                 ), `
( "show-user"                , "Show information about the logged in Azure Sphere user."                    ), `
( "show-version"             , "Show the version of the Azure Sphere tools."                                ), `
( "tenant"                   , "Manage Azure Sphere tenants."                                               ))

Write-Host "azsphere -?" -ForegroundColor Green

ForEach($ln in $Help){ 
    Write-Host $ln[0] ( " " * (24-$ln[0].Length)) -ForegroundColor Yellow -NoNewline
    Write-Host "- " $ln[1] -ForegroundColor Green
}

Write-Host "`nazsphere tenant list" -ForegroundColor Green
azsphere tenant list

Write-Host (&azsphere tenant show-selected)  -ForegroundColor Green
