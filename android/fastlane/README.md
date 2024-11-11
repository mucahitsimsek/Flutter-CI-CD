fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android flutter_pub_get

```sh
[bundle exec] fastlane android flutter_pub_get
```

flutter Pub Get

### android release_android

```sh
[bundle exec] fastlane android release_android
```

Release Android Deployment

### android build_apk

```sh
[bundle exec] fastlane android build_apk
```

Build APK

### android upload_android

```sh
[bundle exec] fastlane android upload_android
```

Upload Android APK to Firebase App Distribution for the specified environment

### android deploy_firebase_dev

```sh
[bundle exec] fastlane android deploy_firebase_dev
```

Deploy Dev Apk to Firebase

### android deploy_firebase_stage

```sh
[bundle exec] fastlane android deploy_firebase_stage
```

Deploy Stage Apk to Firebase

### android deploy_firebase_prod

```sh
[bundle exec] fastlane android deploy_firebase_prod
```

Deploy Prod Apk to Firebase

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
