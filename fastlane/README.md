fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios build_appstore
```
fastlane ios build_appstore
```
Build
### ios upload_testflight
```
fastlane ios upload_testflight
```
Upload to Test Flight
### ios getTeamNames
```
fastlane ios getTeamNames
```

### ios inc
```
fastlane ios inc
```
Increment Build Number
### ios download_keys
```
fastlane ios download_keys
```
Download keys
### ios create_keys
```
fastlane ios create_keys
```
Create keys for new developers

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
