# Over-the-air (OTA) deployment

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).

Unfortunately we'll likely don't have a dish washer and coffee maker at hand but for the purpose of this lab, 
let's have a look at our fictuous Contoso Appliance Cooperation:

Contoso Appliance Cooperation is currently selling three different appliances that are easily distinguishable 
by their color, called "*RedSphere Product*" and "*GreenSphere Product*" and "*BlueSphere Product*".
Our development team has just finished their work on an *IoT Connect* application that will enable Internet connectivety and 
remote control on the existing products and wants the test team to run a field test with selected customers.
Our development team is now evaluating to introduce color combinations to spice up the "*RedSphere Product*" since the master control board (the MT3620 RDB) 
can be fitted into any of the appliances. 
As we want to make sure that all our products are tested on the latest updates to the Azure Sphere Operating system, we also have 
devices of existing products and for our field test in our test-lab and want them to be targeted to use the 
Evaluation version of the Azure Sphere Operating System.

In this lab we will create different application constellations to be deployed by the Azure Sphere Security Service (AS3). To do that, 
we'll setup Products, DeviceGroups and Deployments to deliver different application constellations to the devices.
We'll be move our device between different DeviceGroups and Products.
  
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

We then need to prepare your device for OTA deployment. Open an Azure Sphere Developer Command Prompt Window, change the directory to OTA sample directory and then
run the following command to enable your device to receive OTA application updates:
```sh
azsphere device enable-cloud-test
```

If you followed the Azure Sphere Bootcamp or read the [Deployment basics](https://docs.microsoft.com/en-us/azure-sphere/deployment/deployment-concepts) documentation, you
should already have an understanding of the terms Component, Image, ImageSet and how a Deployment interacts with Products and Device-Groups.

For that you'll find a collection of PowerShell cmdlets in this directory in the [OTA.ps1](./OTA.ps1) file.

1. Open an Azure Sphere Developer Command Prompt Window and change the directory to OTA sample directory and start PowerShell using. 
```sh
powershell -NoExit -Command .\AS3Scripts\OTA.ps1
```

Alternatively, if you want to peek at the source codes aside, you can start the PowerShell development environment with the script loaded. 
```sh
powershell_ise .\AS3Scripts\OTA.ps1
```
Press **F5** to populate the cmdlets and run the script:

In both cases you should see output like
```
ImagePackage .\\IoTConnectHL\\out\\ARM-Debug-3+Beta1909\\IoTConnectHL.imagepackage has ComponentID 33e04e8f-a020-4af8-80d0-8064343e0616 and ImageID e5a28a7d-5118-4e10-903a-4ed6482e8213.
ImagePackage .\\out\\ARM-Debug-3+Beta1909\\RedSphereRT\\RedSphereRT.imagepackage has ComponentID f4e25978-6152-447b-a2a1-64577582f327 and ImageID 1b45e9b9-d339-4905-89c1-2a0ecf16f665.
ImagePackage .\\out\\ARM-Debug-3+Beta1909\\GreenSphereRT\\GreenSphereRT.imagepackage has ComponentID 7e5fab32-801c-4edf-a1aa-9263652aa6bd and ImageID 5ee3ae4b-0a2b-48d6-a933-65e78bf8d105.
ImagePackage .\\out\\ARM-Debug-3+Beta1909\\BlueSphereRT\\BlueSphereRT.imagepackage has ComponentID 07562362-3fec-46c8-b0af-db9507f32748 and ImageID 627f875f-78b9-4d5b-8704-ab16a7b54252.
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
IoTConnect-App (POSIX) 33e04e8f-a020-4af8-80d0-8064343e0616 e5a28a7d-5118-4e10-903a-4ed6482e8213 .\\IoTConnectHL\\out\\ARM-Debug-3+Beta1909\\IoTConnectHL.imagepackage
```
*Note* that the Name-properties on purpose differ from the *app_manifest.json* settings.



**Looking at the operations side**

Let's revisit our fictuous Contoso Appliance Cooperation. 

* We've got three products on the market: the "*RedSphere Product*", "*GreenSphere Product*" and "*BlueSphere Product*". 

For each of the products
* Our operations team needs to manage the retail devices devices at scale with Production devices running the 
Azure Sphere OS Retail version for each of the products
* To ensure compatibility of Production devices with the latest security fixes they also run Production devices 
with the latest Azure Sphere OS Evaluation version in the test-lab.
* The test team runs a Field Test with customers that adds the "*IoT Connect*" application besides the existing Red-/Green-BlueSphere app respectively.
* The test team wants to also run Field Test devices in their test lab on the latest Azure Sphere OS Evaluation version 
* Our dev team wants to spice-up the "*RedSphere Product*" with their upcoming color variations (app constellations) on the latest Azure Sphere OS Evaluation version.

Looking at the definitions 
* A Product is a container for devices grouped into device-groups
* A DeviceGroup defines what Operating System version is delivered to devices in the group and also allows to set a policy for application updates over-the-air.
* A Deployment defines what application software is being delivered to devices in a DeviceGroup

The ops team thus decided to setup the three products in the Azure Sphere Security Service (AS3): 
* "*RedSphere Product*" 
* "*GreenSphere Product*"
* "*BlueSphere Product*"

By default, creating a product in AS3 automatically creates 5 DeviceGroups
* "*Development*"
* "*Field Test*" 
* "*Production*" 
* "*Production OS Evaluation*" 
* "*Field Test OS Evaluation*" 

For the "*RedSphere Product*" we want to add an additional device-group "*Color Variant*" to test over-the-air-updates of new variants.

You can either choose to follow the manual steps get the setup done or follow the PowerShell scripting route.

### Manual operations

**Looking at the Ops side**

1. Let's start creating the "*RedSphere Product*"
```sh
azsphere product create --name "RedSphere Product" --description "The RedSphere Appliance"
```
you should see an output like the following, indicating that the product itself and the 5 default devicegroups have been
successfully created. 
```
Created product 'RedSphere Product' with default device groups:
ID                                   Name
--                                   ----
3560f888-d19b-47dd-ac3d-551bedb2af7b Development
d38ad51d-39df-4be8-be3d-a6f355a3dd2d Field Test
a8bbef58-6233-4f03-9c03-de390138682a Production
5ac74c7d-7f1c-4b39-b14c-d9eb097ecd2b Production OS Evaluation
5210b268-7150-4d99-880f-4f831df957db Field Test OS Evaluation
```
Let's check and compare the details for some DeviceGroups inside the Product using the following
```sh
azsphere device-group show -productname "RedSphere Product" -devicegroupname "Production"
azsphere device-group show -productname "RedSphere Product" -devicegroupname "Development"
```
You should see an output similar to 
```
Getting device group 'Production' for product 'RedSphere Product'.
Successfully retrieved the device group:
   ID:                 'a8bbef58-6233-4f03-9c03-de390138682a'
   Name:               'Production'
   Description:        'Default production device group'
   OS Feed Type:       'Retail'
   Update Policy:      Accept all updates from the Azure Sphere Security Service.
   Current Deployment: None


Getting device group 'Development' for product 'RedSphere Product'.
Successfully retrieved the device group:
   ID:                 '3560f888-d19b-47dd-ac3d-551bedb2af7b'
   Name:               'Development'
   Description:        'Default development device group'
   OS Feed Type:       'Retail'
   Update Policy:      Accept only system software updates.  Don't accept application updates.
   Current Deployment: None
```
2. Looking at the "Development" device-group, you'll realize that it has by default the **OS Feed Type: 'Retail'** set. As we 
want to develop on the latest Azure Sphere Evaluation version we'll need to update the device-group to use 
the **RetailEval** operating system feed:
```sh
azsphere device-group update --productname "RedSphere Product" --devicegroupname "Development" --osfeed RetailEval
```
3. Since we want an additional custom device-group named "*Color Variants*" running on the latest OS realease and OTA-enabled we need to add it using
```sh
azsphere device-group create --productname "RedSphere Product" --name "Color Variant" --osfeed RetailEval --applicationupdate On
```


Now it's your turn to create the products "*GreenSphere Product*" and "*BlueSphere Product*" and 
to update the device-group "Development" with the Azure Sphere Evaluaton OS feed (Hint: the commands below show the
help page with the parameters):
```sh
azsphere prd create -?
azsphere dg update -?
```

**Looking at the Dev side**

Devices in the "Production" as well as "Production OS Evaluation" device-groups should both just run the real-time capable 
applications.
Devices in the "Field Test" and "Field Test OS Evaluation" device-groups should run both the "IoT Connect" high-level application 
together with one of the real-time capable applications.

If you were to upload the same image to both deployments using 
```sh
azsphere dg dep create -pn "RedSphere Product" -dgn "Production" -p ".\out\ARM-Debug-3+Beta1909\RedSphereRT\RedSphereRT.imagepackage" -f
azsphere dg dep create -pn "RedSphere Product" -dgn "Production OS Evaluation" -p ".\out\ARM-Debug-3+Beta1909\RedSphereRT\RedSphereRT.imagepackage" -f
```
you will though receive an error message on the 2nd command:

<div style="background:black;color:white">
Getting device group 'Production OS Evaluation' for product 'RedSphere Product'.<br />
Getting the details of device group 'Production OS Evaluation' for product 'RedSphere Product'.<br />
<span style="color:yellow">warn: '.\out\ARM-Debug-3+Beta1909\RedSphereRT\RedSphereRT.imagepackage' targets Beta APIs that may 
change or be removed in future.</span><br />
<br />
Uploading image from file '.\out\ARM-Debug-3+Beta1909\RedSphereRT\RedSphereRT.imagepackage':<br />
--> Image ID:       f1c5d8dd-16e6-499b-9a6d-b7fd828ee48e<br />
--> Component ID:   f4e25978-6152-447b-a2a1-64577582f327<br />
--> Component name: 'RedSphereRT'<br />
Removing temporary state for uploaded image.<br />
<span style="color:red">error: An image with the same ID ('f1c5d8dd-16e6-499b-9a6d-b7fd828ee48e') already exists.<br />
error: Trace ID: 17b860a1-eff4-44df-bbef-57c8e5814839</span>
</div>


Trying to 

azsphere dg dep create -pn "GreenSphere Product" -dgn "Production" -p ".\out\ARM-Debug-3+Beta1909\GreenSphereRT\GreenSphereRT.imagepackage" -f
azsphere dg dep create -pn "BlueSphere Product" -dgn "Production" -p ".\out\ARM-Debug-3+Beta1909\BlueSphereRT\BlueSphereRT.imagepackage" -f


For our "Field Test"



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
Add-AS3ComponentImage -FilePath $IoTConnectHL.FilePath
Add-AS3ComponentImage -FilePath $RedSphereRT.FilePath
Add-AS3ComponentImage -FilePath $GreenSphereRT.FilePath
Add-AS3ComponentImage -FilePath $BlueSphereRT.FilePath
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



```powershell
$SkuRedSphere = New-AS3ProductSKU -Name $strRedSphereSku -Description "In-field product"
$SkuGreenSphere = New-AS3ProductSKU -Name $strGreenSphereSku -Description "In-field product"
$SkuBlueSphere = New-AS3ProductSKU -Name $strBlueSphereSku -Description "In-field product"

$SkuRedBlueEvaluation = New-AS3ProductSKU -Name $strRedBlueEvaluationSku -Description "Beta software only"
$SkuRedGreenEvaluation = New-AS3ProductSKU -Name $strRedGreenEvaluationSku -Description "Beta software only"
```


At this stage, we now have developed and uploaded three Image-Sets with application combinations of the high level
connectivety app and a single real-time capable app. Addionally ne have two Image-Sets with
with two real-time capable apps (i.e. one app per M4 core).
Let's now take a look at the Ops side.
---
[Go back to "Multi-Core app and OTA deployment lab"](../README.MD)

---

### Disclaimer

#### Sample code - No Warranties
THE SAMPLE CODE SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTY.TO THE MAXIMUM EXTENT 
PERMITTED BY LAW, MICROSOFT DISCLAIMS ANY AND ALL OTHER WARRANTIES, WHETHER EXPRESS OR 
IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, 
NON - INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE, WHETHER ARISING BY A COURSE 
OF DEALING, USAGE OR TRADE PRACTICE OR COURSE OF PERFORMANCE.
In no event shall Microsoft, its licensors, the authors or copyright holders be liable 
for any claim, damages or other liability, whether in an action of contract, tort or 
otherwise, arising from, out of or in connection with the software or the use thereof.

This code may contain errors and/or may not operate correctly. Microsoft undertakes no 
duty to correct any errors or update the software. Your use of this code is optional and 
subject to any license provided therewith or referenced therein, if any. Microsoft does 
not provide you with any license or other rights to any Microsoft product or service 
through the code provided to you.
