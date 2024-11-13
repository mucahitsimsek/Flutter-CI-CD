<div align="center"><h1>Flutter CI/CD Processes</h1></div>

## Presentation
- The aim of our project is to show how CI/CD processes work in a real-time project.
- The CI/CD process in Flutter is to automate what we do manually using Github Actions. In this way, you can quickly get builds, test and production versions.
  
## Requirements
- I preferred to use [Firebase App Distribution](https://firebase.google.com/docs/app-distribution?hl=tr) instead of using any store for testing in the project.
- We used Github Actions. We need to automate our work and use it from a virtual space. [This Project Actions](https://github.com/mucahitsimsek/Flutter-Flavor-Create/actions)
- [Fastlane](https://docs.fastlane.tools/) It is a practical solution that automates the easy creation and release of new versions to test and production environments.
- I used [Flavor](https://saileshdahal.com.np/flavor-setup-flutter) **(You can also learn about the flavor processes with the similarities I made here.)** in Flutter because I want to create development-stage-production environments to separate testing processes and features that are still in development.

<div align="center"><h3>Steps</h3></div>

- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution?hl=tr) Setup
- [Flavor](https://docs.flutter.dev/deployment/flavors) Setup:
  - First of all, we have to define the environments we want to create. Here are the things we demand: 
    - New features should not affect active users.
    - Features that have finished development need to be tested.
    - Successfully tested features should be ready to be presented to the user.
    In line with these steps, the following environment emerges:
        - Development
        - Staging
        - Production
    - Using these environments, let's first write our target code and then complete the installations on iOS and Android locally.
- [Fastlane](https://docs.flutter.dev/deployment/cd#fastlane)  Setup:
    - We will cover fastlane installations directly for [iOS](https://docs.fastlane.tools/getting-started/ios/setup/) and [Android](https://docs.fastlane.tools/getting-started/android/setup/). Therefore, if you want to proceed through the doc, please proceed through these tabs.
- [Github Actions](https://docs.github.com/en/actions/writing-workflows/quickstart) Setup: 
    - With the environments we used in Flavor, we will automate the codes we wrote in fastlane at this stage. To do this, we will create a 📂 **workflows** folder under the 📂 **.github/** folder in the main hierarchy of the project and ensure that our 📄 **.yml** files are triggered.

## Firebase App Distribution
[iOS Distribution](https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane?hl=tr) <br/>
[Android Distribution](https://firebase.google.com/docs/app-distribution/android/distribute-fastlane?hl=tr) <br/>
[My Android Distribution](/android/fastlane/Fastfile) <br/>
[My iOS Distribution](/ios/fastlane/Fastfile). **I will add it soon.** 

## Flavor - Dart
- First we will use the --dart-define parameter. This is to prevent creating more than one main.dart file. In this way, we will be able to easily understand which env is being run on a single path. For this, let's update [.vscode/launch.json](/.vscode/launch.json) as below.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch development",
            "request": "launch",
            "type": "dart",
            "program": "lib/main.dart",
            "args": [
                "--flavor",
                "development",
                "--target",
                "lib/main.dart",
                "--dart-define",
                "ENVIRONMENT=dev"
            ]
        },
    ]
}

```
- This [dart-define](https://dartcode.org/docs/using-dart-define-in-flutter/) parameter provides us the value directly when the project starts. 
- If you want to run from the terminal:
```bash
flutter run --flavor development --target=lib/main.dart --dart-define=ENVIRONMENT=dev
```
- As we talked about in the posts above, we were creating 3 environments: production, staging and development.
Accordingly, we code the following dart file for flutter installation.
[flavor_config.dart](/lib/base/config/flavor_config.dart)
```dart
final class FlavorConfiguration {
  final EnvironmentType environmentType;
  final String baseUrl;

  FlavorConfiguration._({required this.environmentType, required this.baseUrl});

  static final _env = EnvironmentType.currentEnv;

  static final FlavorConfiguration instance = FlavorConfiguration._(
    environmentType: _env,
    baseUrl: _env.baseUrl,
  );
}
```
- We need to define the environment type in the following way.
```dart
enum EnvironmentType {
  dev(FlavorConst.dev),
  stage(FlavorConst.stage),
  prod(FlavorConst.prod);

  const EnvironmentType(this.environment);

  final String environment;

  static EnvironmentType get currentEnv => EnvironmentType.fromString(
      const String.fromEnvironment(FlavorConst.environment));

  String get baseUrl {
    return switch (currentEnv) {
      dev => FlavorConst.devUrl,
      stage => FlavorConst.stageUrl,
      prod => FlavorConst.prodUrl,
    };
  }

  static EnvironmentType fromString(String value) {
    return EnvironmentType.values.firstWhere(
      (e) => e.environment == value,
      orElse: () => throw UnknownDevice(value),
    );
  }

  bool get isDev => currentEnv == dev;
  bool get isStage => currentEnv == stage;
  bool get isProd => currentEnv == prod;
}
```

## Flavor - iOS
- Open your project in Xcode.
- To add a new Schema, select Product > Schema > New Schema from the menu. Then let's name the schema as production, staging and development.
    - In order to separate existing configurations from other configurations, we must first add new configurations for the schemas we will create.
    - Under the Info tab at the end of the Configurations dropdown list, click the plus button and duplicate each configuration name (Debug, Release, and Profile). Duplicate the existing configurations, once for each environment.
<br/><img src="/images/ios/ios-runner-config.png"/>
- **Then we create schemes to map the configurations we created. We map the schemes we created with configurations. You can examine the visuals:**
<br/><img src="/images/ios/ios-schemes.png"/>
<br/><img src="/images/ios/ios-scheme.png"/>
- After these operations, we need to update the project bundle ids. 
<br/><img src="/images/ios/ios-bundle-id.png"/>
- As a last step, we update the name of our application so that we can analyze the environment in which it works **(APP_DISPLAY_NAME ADDED ON INFO.PLIST)**.
<br/><img src="/images/ios/ios-display-name.png"/>
<br/><img src="/images/ios/ios-display-name-2.png"/>

## Flavor - Android
- For Android configuration you need to add the following conditions in [android/app/build.gradle](/android/app/build.gradle#L78-L96):
```gradle
    flavorDimensions "default"

    productFlavors { 
        production {
            dimension "default"
            applicationIdSuffix ""
            manifestPlaceholders = [appName: "YOUR APP NAME"]
        }
        staging {
            dimension "default"
            applicationIdSuffix ".stg"
            manifestPlaceholders = [appName: "[STG] YOUR APP NAME"]
        }
        development {
            dimension "default"
            applicationIdSuffix ".dev"
            manifestPlaceholders = [appName: "[DEV] YOUR APP NAME"]
        }
    }
```
- Please update the [Android Manifest File](/android/app/src/main/AndroidManifest.xml) as follows.
```xml
    <application
        android:label="${appName}"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
```
- If you want to update the icons in android, you need to update the [src](/android/app/src/) content as in the image.
<br/><img src="/images/android/app-src.png"/>

## Fastlane
- Please review the following folders:
    - [iOS](/ios/fastlane)
    - [Android](/android/fastlane)

**For Details:**
<br/>

[Fastlane Docs](https://docs.fastlane.tools/)

## Github Actions
- We need to automate the processes we have done so far. For this, we will use Github Actions.
- We will create a new folder under the .github folder in the main hierarchy of the project and name it workflows.
- In this folder we will create a new file and name it as you like. You can see my nomenclature here:
    - [.github/workflows](/.github/workflows)
- When you examine the workflows we created, there are pr-check and deploys. Of these, [pr-check](/.github/workflows/pr-check.yml) will work when a pull request is created. The other workflows are set to run when merge to dev-stage-main branches. 
- Whichever branch pr is accepted, the deployment process will start as a result of the action triggered in this case. For example, [deploy-dev-android](/.github/workflows/deploy-dev-android.yml) requires merge to the “dev” branch.

- I connected to github actions on my device, follow these steps to do it on yours: 
    - Open Github repository
    - Click on the Settings tab, from there open the actions menu.
<br/><img src="/images/github/github-settings.png"/>
    - Click on runners and create a runner. 
<br/><img src="/images/github/github-create-runner.png"/>
    - After creating the Runner, it will look like this.
<br/><img src="/images/github/github-runners.png"/>
    