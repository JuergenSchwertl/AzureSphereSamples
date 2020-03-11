# Over-the-air (OTA) deployment (Scripted)

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).

## Prerequisites

- Have the [IoTConnectHL application](../IoTConnectHL/README.MD) and the three [Realtime-capable applications](../RedSphereRT/README.MD) 
imagepackages built and ready to run.

## Prep your environment 
>**Note:** PowerShell by default is configured to only run scripts that are code-signed by a trusted CA. To run the *OTA.ps1* script you 
>therefore need to change the execution policy.
>
>To do this you need to open an administrative command shell and run
```Powershell
powershell Set-ExecutionPolicy unrestricted
```
Then close the admin command shell again since you should only run on elevated priviledges when absolutely required.

If you followed the Azure Sphere Bootcamp or read the [Deployment basics](https://docs.microsoft.com/en-us/azure-sphere/deployment/deployment-concepts) 
documentation, you should already have an understanding of the terms Component, Image, ImageSet and how a Deployment interacts with Products and DeviceGroups.

For that you'll find a collection of PowerShell cmdlets in this directory in the [OTA.ps1](./OTA.ps1) file.

1. Open an Azure Sphere Developer Command Prompt Window and change the directory to the OTA sample directory and start PowerShell using. 
```sh
powershell -NoExit -Command Import-Module .\AS3Scripts\OTA.ps1
```

Alternatively, if you're running on Windows and want to peek at the source codes aside, you can start the PowerShell development environment with the script loaded. 
```sh
powershell_ise .\AS3Scripts\OTA.ps1
```
Press **F5** to populate the cmdlets and run the script:

In both cases you should see output like
```
Checking for image-packages in directory tree....
Found 'IoTConnectHL' with ImageId 29441244-b818-49d4-941d-62b8d41def92
Found 'RedSphereRT' with ImageId f443064f-e969-4d5d-ae2a-1fd6162fa5ac
Found 'GreenSphereRT' with ImageId b950fb18-6d4b-4702-aaef-fd196c280b64
Found 'BlueSphereRT' with ImageId c94089e9-1a26-48c9-b4b7-a1e9a3c42051

Checking for products already available in Azure Sphere Security Service....
WARNING: Cannot find product 'RedSphere Product': follow the OTA sample steps to create the product...
WARNING: Cannot find product 'GreenSphere Product': follow the OTA sample steps to create the product...
WARNING: Cannot find product 'BlueSphere Product': follow the OTA sample steps to create the product...
PS C:\Repos\AzureSphereSamples\OTA>
```

The script checks if the imagepackage files are readily available and sets a few prerequisites. To ease the handling 
it sets global structures reading the ComponentID and ImageID directly from the .imagepackage files (see the *ExtractFrom-ImagePackage* cmdlet) 
for each of the applications so you can reference them by name like: *$IoTConnectHL*, *$RedSphereRT*, *$BlueSphereRT* and *$GreenSphereRT*. 

Just check one of the variables to see the content
```sh
PS C:\Repos\AzureSphereSamples\OTA> $IoTConnectHL

Name                   ComponentID                          ImageID                              FilePath                                                            
----                   -----------                          -------                              --------                                                            
IoTConnect-App (POSIX) 33e04e8f-a020-4af8-80d0-8064343e0616 e5a28a7d-5118-4e10-903a-4ed6482e8213 .\\IoTConnectHL\\out\\ARM-Debug-4+Beta2001\\IoTConnectHL.imagepackage
```

>**Note** 
>If you happened to run the manual instructions, the three Products and their Devicegroups will already exist. You can then continue with [Create Deployments](#Create Deployments).  

#### Create products
```PowerShell
$RedSphereProduct = New-AS3Product -Name "RedSphere Product" -Description "The RedSphere Appliance"
$GreenSphereProduct = New-AS3Product -Name "GreenSphere Product" -Description "The GreenSphere Appliance"
$BlueSphereProduct = New-AS3Product -Name "BlueSphere Product" -Description "The BlueSphere Appliance"
```

Since the `New-AS3Product` creates the Product with it's default devicegroups, it also implicitly loads the devicegroup-list, so that we
can access them e.g. through  `$Global:RedSphereProduct.DeviceGroupList["Production"].Guid` (you can omit the .Guid though).

#### Upload Images

The script has the relative paths to the image packages pre-defined and has extracted the ImageId of the ImagePackage already
```PowerShell
Add-AS3Image -FilePath $IoTConnectHL.FilePath
Add-AS3Image -FilePath $RedSphere.FilePath
Add-AS3Image -FilePath $GreenSphereRT.FilePath
Add-AS3Image -FilePath $BlueSphere.FilePath
```

#### Create Deployments

```PowerShell
New-AS3Deployment -DeviceGroupId $RedSphereProduct.DeviceGroupList["Production"] -Images $RedSphereRT.ImageID
New-AS3Deployment -DeviceGroupId $RedSphereProduct.DeviceGroupList["Production OS Evaluation"] -Images $RedSphereRT.ImageID
New-AS3Deployment -DeviceGroupId $RedSphereProduct.DeviceGroupList["Field Test"] -Images $RedSphereRT.ImageID, $IoTConnectHL.ImageID
New-AS3Deployment -DeviceGroupId $RedSphereProduct.DeviceGroupList["Field Test OS Evaluation"] -Images $RedSphereRT.ImageID, $IoTConnectHL.ImageID
```

I leave it up to you to do the same for the `GreenSphere Product` and the `BlueSphere Product` accordingly.


#### Enabling your device for OTA updates 
We then need to prepare your device for OTA deployment. Run the following command to enable your device to receive OTA application updates and at the 
same time assign it to the *RedSphere Product* and it's *Production* devicegroup; this time using the device group id implicitly:
```PowerShell
& azsphere dev ect -dgi $RedSphereProduct.DeviceGroupList["Production"]
```
During that process, your device will reboot and after a minute you'll see the 1st LED Blinking red.
```PowerShell
azsphere dev img list-targeted
azsphere dev img list-installed
azsphere dev app show-status
```
will now show that the device is targeted with the RedSphereRT application, that this application is installed and also running.



Now change it to another product and device group
```PowerShell
azsphere dev upd -dgi $GreenSphereProduct.DeviceGroupList["Field Test"]
```
You would expect the green LED starting to blink but will realize that not much is going to change. 
```PowerShell
azsphere dev img list-targeted
azsphere dev img list-installed
azsphere dev app show-status
```
reveals that the device is now targeted with the GreenSphereRT and IoTConnectHL application but still RedSphere being installed and running.

The reason is that Azure Sphere only checks for application updates every 24 hours (once the device certificate expires and is being renewed) and 
since we just enabled cloud testing which rebootet the device we'd now have to wait for a day, unless we quickly hit the **Reset** button, to force a reboot.

After Reboot it will still start the old (RedSphereRT) application while in the background it will be checking with the Azure Sphere Security Service for 
application updates, find that it is now targeted the GreenSphereRT deployment, download the image package(s), then send a SIG_TERM to the RedSphereRT app
to gracefully have it terminated and only afterwards start the GreenSphereRT .  
```PowerShell
azsphere dev img list-targeted
azsphere dev img list-installed
azsphere dev app show-status
```
also reveals that we now have both targeted apps installed and running.

### Well done!
