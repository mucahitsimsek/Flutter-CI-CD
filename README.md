<div align="center">
    <h1>Flutter CI/CD Processes</h1>
</div>

## Presentation
- The aim of our project is to show how CI/CD processes work in a real-time project.
- The CI/CD process in Flutter is to automate what we do manually using Github Actions. In this way, you can quickly get builds, test and production versions.
  
## Requirements
- I preferred to use [Firebase App Distribution](https://firebase.google.com/docs/app-distribution?hl=tr) instead of using any store for testing in the project.
- We used Github Actions. We need to automate our work and use it from a virtual space. [This Project Actions](https://github.com/mucahitsimsek/Flutter-Flavor-Create/actions)
- [Fastlane](https://docs.fastlane.tools/) It is a practical solution that automates the easy creation and release of new versions to test and production environments.
- I used [Flavor](https://saileshdahal.com.np/flavor-setup-flutter) **(You can also learn about the flavor processes with the similarities I made here.)** in Flutter because I want to create development-stage-production environments to separate testing processes and features that are still in development.

## Steps
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

## Flavor
- Open your project in Xcode.
- To add a new Schema, select Product > Schema > New Schema from the menu. Then let's name the schema as production, staging and development. Example:

  
