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
- Flavor Setup:
  - First of all, we have to define the environments we want to create. Here are the things we demand: 
    - New features should not affect active users.
    - Features that have finished development need to be tested.
    - Successfully tested features should be ready to be presented to the user.
    In line with these steps, the following environment emerges:
        - Development
        - Staging
        - Production
## iOS Flavor Setup:
```
- Open Xcode and select the Runner target in your project.
- Under the Runner project, right-click Runner in the Targets section and Duplicate to create a copy of it.
- Give the new target a name such as Production, Development or Staging. (All 3 environments must be created as a scheme).
- Update the Bundle Identifier for each target so that each environment is unique (for example, com.example.app.dev).
- In Build Configuration, update the Debug, Release, Profile settings for each target.
```
