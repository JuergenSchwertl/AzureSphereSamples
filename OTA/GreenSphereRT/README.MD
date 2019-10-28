# GreenSphereRT sample: MT3620 real-time capability application - Bare Metal GPIO

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
For information about hiw to build th real-time capable application please refer to 
[RedSphereRT](../RedSphereRT/README.MD)


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
[OTA and multi-core sample](../README.MD)
