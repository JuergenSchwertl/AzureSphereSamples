# GreenSphereRT sample: MT3620 real-time capability application - Bare Metal GPIO

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
For information about how to build the real-time capable application please refer to 
[RedSphereRT](../RedSphereRT/README.MD)

**Manually deploy the GreenSphereRT application**

1. Open an Azure Sphere Developer Command Prompt and navigate to the OTA folder. 
1. Deploy the application using 
```sh
 azsphere dev sl deploy -p "out\ARM-Debug-4+Beta2001\GreenSphereRT\GreenSphereRT.imagepackage" 
```
You will see that Led2 starts blinking in green at a fast rate, likely at a different frequency than Led1 in red.
1. Once you press Button A both will start blinking at the same frequency as both have received the 'BLNK' message 
1. Stop the application using
```sh
 azsphere dev app stop -i 7E5FAB32-801C-4EDF-A1AA-9263652AA6BD
```
You will see that the high-level application gracefully recovers and starts sending *PING* messages to the remaining RedSphereRT app.
1. Remove the application manually using
```sh
azsphere dev sl delete -i 7E5FAB32-801C-4EDF-A1AA-9263652AA6BD
```


**Note:** The *app_manifest.json* differs between the real-time capable applications obviously 
on the *"Name"*, *"ComponentId"* properties and most notably in the used "Gpio".

```json
{
  "SchemaVersion": 1,
  "Name": "GreenSphereRT",
  "ComponentId": "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD",
  "EntryPoint": "/bin/app",
  "CmdArgs": [ "GreenSphere" ],
  "Capabilities": {
    "AllowedApplicationConnections": [ "33e04e8f-a020-4af8-80d0-8064343e0616" ],
    "Gpio": [ 16 ]
  },
  "ApplicationType": "RealTimeCapable"
}
```

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
