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
We'll also move our device between different DeviceGroups and Products to see how different applications will be deployed over the air.
  
## Prerequisites

- Have the [IoTConnectHL application](../IoTConnectHL/README.MD) and the three [Realtime-capable applications](../RedSphereRT/README.MD) 
imagepackages built and ready to run.

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

## Manual operations

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
want to develop on the latest Azure Sphere Evaluation version we want to update the device-group to use 
the **RetailEval** operating system feed:
```sh
azsphere device-group update --productname "RedSphere Product" --devicegroupname "Development" --osfeed RetailEval
```
3. Since we want an additional custom device-group named "*Color Variants*" running on the latest OS realease and OTA-enabled we need to add it using
```sh
azsphere device-group create --productname "RedSphere Product" --name "Color Variant" --osfeed RetailEval --applicationupdate On
```


4. Now it's your turn to create the products "*GreenSphere Product*" and "*BlueSphere Product*" and 
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

If you would attempt to create the deployments e.g. using 
```sh
azsphere dg dep create -pn "RedSphere Product" -dgn "Production" -p ".\RedSphereRT\out\ARM-Debug\RedSphereRT.imagepackage" -f
azsphere dg dep create -pn "RedSphere Product" -dgn "Production OS Evaluation" -p ".\RedSphereRT\out\ARM-Debug\RedSphereRT.imagepackage" -f
```
you will though receive an error message on the 2nd command, complaining that "*An image with the same ID ('f1c5d8dd-16e6-499b-9a6d-b7fd828ee48e') already exists.*"
since the 1st command implicitly already uploaded the image-package for the RedSphereRT application. 
Since running the same application (or application combinations) in deployments on different device groups is 
a rather common scenario, we need to take a slightly different route and first upload the current application image-packages and 
then create the deployments referencing the uploaded image packages by their ImageId.

```sh
azsphere img add -f ".\RedSphereRT\out\ARM-Debug\RedSphereRT.imagepackage" --force
azsphere img add -f ".\GreenSphereRT\out\ARM-Debug\GreenSphereRT.imagepackage" --force
azsphere img add -f ".\BlueSphereRT\out\ARM-Debug\BlueSphereRT.imagepackage" --force
azsphere img add -f ".\IoTConnectHL\out\ARM-Debug\IoTConnectHL.imagepackage" --force
```

you should see an output like:
```
C:\Repos\AzureSphereSamples\OTA>azsphere img add -f ".\RedSphereRT\out\ARM-Debug\RedSphereRT.imagepackage" --force
warn: '.\out\ARM-Debug-4+Beta2001\RedSphereRT\RedSphereRT.imagepackage' targets Beta APIs that may change or be removed in future.
Uploading image from file '.\RedSphereRT\out\ARM-Debug\RedSphereRT.imagepackage':
 --> Image ID:       8e224bb1-9440-423d-9b8e-e2d05f1902a7
 --> Component ID:   f4e25978-6152-447b-a2a1-64577582f327
 --> Component name: 'RedSphereRT'
Removing temporary state for uploaded image.
Successfully uploaded image with ID '8e224bb1-9440-423d-9b8e-e2d05f1902a7' and name 'RedSphereRT' to component with ID 'f4e25978-6152-447b-a2a1-64577582f327'.
```

To proceed further you need to note down the individual ImageID´s to create the deployments along the lines of  

<pre><code>azsphere dg dep create -pn "RedSphere Product" -dgn "Production" -ii <i>[RedSphereRT-ImageID]</i> -f
azsphere dg dep create -pn "RedSphere Product" -dgn "Production OS Evaluation" -ii <i>[RedSphereRT-ImageID]</i> -f
azsphere dg dep create -pn "RedSphere Product" -dgn "Field Test" -ii <i>[RedSphereRT-ImageID],[IoTConnectHL-ImageID]</i> -f
azsphere dg dep create -pn "RedSphere Product" -dgn "Field Test OS Evaluation" -ii <i>[RedSphereRT-ImageID],[IoTConnectHL-ImageID]</i> -f
</code></pre>
I leave it up to you to do the same for the other products.


>**Note:**: 
>If you don't like to copy&paste IDs, now would be a good time to switch to [PowerShell scripted operations](./SCRIPTED.MD) 


We then need to prepare your device for OTA deployment. Open an Azure Sphere Developer Command Prompt Window, change the directory to OTA sample directory and then
run the following command to enable your device to receive OTA application updates and at the sam etime assign it to one of our devicegroups:
```sh
azsphere device enable-cloud-test -pn "RedSphere Product" -dgn "Production"
```
During that process, your device will reboot and after a minute you'll see the 1st LED Blinking red.
```sh
azsphere dev img list-targeted
azsphere dev img list-installed
azsphere dev app show-status
```
will now show that the device is targeted with the RedSphereRT application, that this application is installed and also running.



Now change it to another product and device group
```sh
azsphere device update -pn "GreenSphere Product" -dgn "Field Test"
```
You would expect the green LED starting blinking but will realize that not much is going to change. 
```sh
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
```sh
azsphere dev img list-targeted
azsphere dev img list-installed
azsphere dev app show-status
```
also reveals that we now have both targeted apps installed and running.

### Well done!




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
