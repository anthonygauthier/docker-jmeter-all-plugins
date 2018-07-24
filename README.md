# Docker-jmeter-all-plugins
## Quick info
Based on the OpenJDK/jre-9 image. This image installs JMeter, installs all the plugins and add environment variables. This is especially useful in a CI/CD context where performance/load testing is done within the pipeline.

Versions can easily be changed via the following variables :

```
JMETER_VERSION
JMETER_PMANAGER_VERSION
CMDRUNNER_VERSION
```

Current versions :

| Component |      Version     |
|-----------|:----------------:|
|  JMeter   |       4.0        |
|JMeter PluginsManager |  1.2 |
|CMDRunner  |       2.2        |

## Contributing
For any issues, suggestions simply create an issue on this repository. To contribute, fork away and make a pull request! :-)
