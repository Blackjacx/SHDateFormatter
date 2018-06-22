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
or alternatively using `brew cask install fastlane`

# Available Actions
### run_framework_tests
```
fastlane run_framework_tests
```
Runs tests using scan
### release_to_cocoapods
```
fastlane release_to_cocoapods
```
Creates a release branch

Runs framework tests

Increments framework number

Updates podspec file

Pushes podspec file to Cocoapods

Pushes releases to github

Commits and pushes changes to remote and tags the release commit

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
