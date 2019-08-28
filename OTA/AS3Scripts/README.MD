# Over-the-air (OTA) deployment

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).

In this lab we will create different application constellations to be deployed by the Azure Sphere Security Service (AS3). To do that, 
we'll setup DeviceGroups, SKUs and upload our Components into different ImageSet constellations and finally 
create the Feeds delivering the software to the device. 
To see how Feeds, SKUs and Device-Groups interact we'll move our device between different Device-Groups and SKUs.

Let's have a look at our fictuous Contoso Appliance Cooperation. We're currently selling three different Internet connected appliances
that are easily distinguishable by their color, called RedSphere, GreenSphere and BlueSphere. For that we have a master control board developed
 (the MT3620 RDB) that can be fitted into each of the appliances. Our product design team is evaluating to add more color to life
so the test-lab runs some new color combinations.
  
## Prerequisites

- Have the [IoTConnectHL application](../IoTConnectHL/README.MD) and the three [Realtime-capable applications](../RedSphereRT/README.MD) imagepackages built and ready to run.

## Prep your environment 
First you need to prepare your device for OTA deployment. Open an Azure Sphere Developer Command Prompt Window, change the directory to OTA sample directory and then
run the following command to enable your device to receive OTA application updates:
```sh
azsphere dev prep-field
```

If you followed the Azure Sphere Bootcamp or read the [Deployment basics](https://docs.microsoft.com/en-us/azure-sphere/deployment/deployment-concepts) documentation, you
should already have an understanding of the terms Component, Image, ImageSet and how a Feed interacts with SKUs and Device-Groups.

>*Note:* Although AZSPHERE.EXE offers helpful commands that combine several steps in one, in this lab we're building the
>environment step-by-step. As most of the parameters for the AZSPHERE tool are Guids and sometimes you need the Guid
>that one operation created as parameter for another operation and Guids are somewhat easy to mix up, let's start ```scripting``` our way 
>through the Azure Sphere Security Service (AS3).

For that you'll find a collection of PowerShell cmdlets in this directory in the [OTA.ps1](./OTA.ps1) file.

1. Open an Azure Sphere Developer Command Prompt Window and change the directory to OTA sample directory and start PowerShell using. 
```sh
powershell -NoExit -Command .\AS3Scripts\OTA.ps1
```

Alternatively, if you want to peek at the source codes aside, you can start the PowerShell development environment with the script loaded. 
Press **F5** to populate the cmdlets and run the script:
```sh
powershell_ise .\AS3Scripts\OTA.ps1
```

In both cases you should see output like
```
ImagePackage .\\IoTConnectHL\\out\\ARM-Debug-2Beta1905\\IoTConnectHL.imagepackage has ComponentID 33e04e8f-a020-4af8-80d0-8064343e0616 and ImageID e5a28a7d-5118-4e10-903a-4ed6482e8213.
ImagePackage .\\out\\ARM-Debug-2Beta1905\\RedSphereRT\\RedSphereRT.imagepackage has ComponentID f4e25978-6152-447b-a2a1-64577582f327 and ImageID 1b45e9b9-d339-4905-89c1-2a0ecf16f665.
ImagePackage .\\out\\ARM-Debug-2Beta1905\\GreenSphereRT\\GreenSphereRT.imagepackage has ComponentID 7e5fab32-801c-4edf-a1aa-9263652aa6bd and ImageID 5ee3ae4b-0a2b-48d6-a933-65e78bf8d105.
ImagePackage .\\out\\ARM-Debug-2Beta1905\\BlueSphereRT\\BlueSphereRT.imagepackage has ComponentID 07562362-3fec-46c8-b0af-db9507f32748 and ImageID 627f875f-78b9-4d5b-8704-ab16a7b54252.
PS C:\Repos\AzureSphereSamples\OTA>
```

The script checks if the imagepackage files are readily available and sets a few prerequisites. To ease the handling 
it sets global structures reading the ComponentID and ImageID directly from the .imagepackage files (see the *ExtractFrom-ImagePackage* cmdlet) 
for each of the applications so you can reference them by name like: *$IoTConnectHL*, *RedSphereRT*, *$BlueSphereRT* and *$GreenSphereRT*. 

Just check one of the variables to see the content
```sh
PS C:\Repos\AzureSphereSamples\OTA> $IoTConnectHL

Name                   ComponentID                          ImageID                              FilePath                                                            
----                   -----------                          -------                              --------                                                            
IoTConnect-App (POSIX) 33e04e8f-a020-4af8-80d0-8064343e0616 e5a28a7d-5118-4e10-903a-4ed6482e8213 .\\IoTConnectHL\\out\\ARM-Debug-2Beta1905\\IoTConnectHL.imagepackage
```
*Note* that the Name-properties on purpose differ from the *app_manifest.json* settings.

**Looking at the software side**

Each appliance needs to run one of the real-time capable applications (*Red-/Green-/BlueSphereRT*) together with the connectivety app *IoTConnectHL*.
In AS3 terms, this requires an ImageSet that contains two Images of two different Components:
1. Create the Component-entries in AS3 by running the following script commands
```powershell
azsphere component create --componentid $IoTConnectHL.ComponentID  --name $IoTConnectHL.Name
azsphere component create --componentid $RedSphereRT.ComponentID   --name $RedSphereRT.Name
azsphere component create --componentid $GreenSphereRT.ComponentID --name $GreenSphereRT.Name
azsphere component create --componentid $BlueSphereRT.ComponentID  --name $BlueSphereRT.Name
```
alternative you could use the included cmdlet *New-AS3Component* that wraps the same calls but also offers an ErrorAction to stop execution of the script
```powershell
New-AS3Component -ComponentID $IoTConnectHL.ComponentID  -Name $IoTConnectHL.Name
New-AS3Component -ComponentID $RedSphereRT.ComponentID   -Name $RedSphereRT.Name
New-AS3Component -ComponentID $GreenSphereRT.ComponentID -Name $GreenSphereRT.Name
New-AS3Component -ComponentID $BlueSphereRT.ComponentID  -Name $BlueSphereRT.Name
```
2. Now upload the individual Images. We're using Beta-APIs in our applications, which requires to *--force* the upload.
```powershell
azsphere component image add --filepath $IoTConnectHL.FilePath --force
azsphere component image add --filepath $RedSphereRT.FilePath --force
azsphere component image add --filepath $GreenSphereRT.FilePath --force
azsphere component image add --filepath $BlueSphereRT.FilePath --force
```
Similar to the above, the *Add-AS3ComponentImage* cmdlet wraps these calls, returning the ImageID for further use and stops script execution on error
```powershell
New-AS3ComponentImage -FilePath $IoTConnectHL.FilePath
New-AS3ComponentImage -FilePath $RedSphereRT.FilePath
New-AS3ComponentImage -FilePath $GreenSphereRT.FilePath
New-AS3ComponentImage -FilePath $BlueSphereRT.FilePath
```
3. At last we create the three standard ImageSets with connectivety-app and real-time capable app and two additional "beta"-imagesets.
*Note:* we preserve the returned ImageSetID of the cmdlet
```powershell
$RedImageSet   = New-AS3ImageSet $IoTConnectHL.ImageID,$RedSphereRT.ImageID   -Name "Connected-RedSphere v1.0"
$GreenImageSet = New-AS3ImageSet $IoTConnectHL.ImageID,$GreenSphereRT.ImageID -Name "Connected-GreenSphere v1.0"
$BlueImageSet  = New-AS3ImageSet $IoTConnectHL.ImageID,$BlueSphereRT.ImageID  -Name "Connected-RedSphere v1.0"

$RedGreenImageSet = New-AS3ImageSet $IoTConnectHL.ImageID,$RedSphereRT.ImageID,$GreenSphereRT.ImageID  -Name "Connected-RedGreenSphere Beta1"
$RedBlueImageSet = New-AS3ImageSet $IoTConnectHL.ImageID,$RedSphereRT.ImageID,$BlueSphereRT.ImageID   -Name "Connected-RedBlueSphere Beta1"
```

**Looking at the operations side**
