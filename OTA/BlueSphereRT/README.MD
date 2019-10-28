# BlueSphereRT sample: MT3620 real-time capability application - Bare Metal GPIO

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
For information about how to build the real-time capable application please refer to 
[RedSphereRT](../RedSphereRT/README.MD).

**Note:** The *app_manifest.json* differs between the real-time capable applications obviously 
on the *"Name"*, *"ComponentId"* properties and most notably in the used "Gpio".

```json
{
  "SchemaVersion": 1,
  "Name": "BlueSphereRT",
  "ComponentId": "07562362-3FEC-46C8-B0AF-DB9507F32748",
  "EntryPoint": "/bin/app",
  "CmdArgs": [ "BlueSphere" ],
  "Capabilities": {
    "AllowedApplicationConnections": [ "33e04e8f-a020-4af8-80d0-8064343e0616" ],
    "Gpio": [ 8 ]
  },
  "ApplicationType": "RealTimeCapable"
}
```

---
[OTA and multi-core sample](../README.MD)
