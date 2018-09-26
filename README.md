<h1 align="center">SHDateFormatter</h1>

<p align="center">
  <a href="https://app.bitrise.io/app/79dbf282186be219"><img alt="Build Status" src="https://app.bitrise.io/app/79dbf282186be219/status.svg?token=1Q3QQ9SkwDwNLZ2j1X7n9Q&branch=develop" /></a>
  <img alt="Github Current Release" src="https://img.shields.io/github/release/blackjacx/SHDateFormatter.svg" /> 
  <img alt="Cocoapods Platforms" src="https://img.shields.io/cocoapods/p/SHDateFormatter.svg" />
  <img alt="Xcode 10.0+" src="https://img.shields.io/badge/Xcode-10.0%2B-blue.svg" />
  <img alt="iOS 9.0+" src="https://img.shields.io/badge/iOS-9.0%2B-blue.svg" />
  <img alt="Swift 4.2+" src="https://img.shields.io/badge/Swift-4.2%2B-orange.svg" />
  <img alt="Github Repo Size" src="https://img.shields.io/github/repo-size/blackjacx/SHDateFormatter.svg" />
  <img alt="Github Code Size" src="https://img.shields.io/github/languages/code-size/blackjacx/SHDateFormatter.svg" />
  <img alt="Github Closed PR's" src="https://img.shields.io/github/issues-pr-closed/blackjacx/SHDateFormatter.svg" />
  <!-- <a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat" /></a> -->
  <a href="https://github.com/Blackjacx/SHDateFormatter/blob/develop/LICENSE?raw=true"><img alt="License" src="https://img.shields.io/cocoapods/l/SHDateFormatter.svg?style=flat" /></a>
  <!-- <a href="https://codecov.io/gh/blackjacx/SHDateFormatter"><img alt="Codecov" src="https://codecov.io/gh/blackjacx/SHDateFormatter/branch/master/graph/badge.svg" /></a> -->
  <a href="https://codebeat.co/projects/github-com-blackjacx-shdateformatter-develop"><img alt="codebeat badge" src="https://codebeat.co/badges/c74826a3-8f8b-41da-8daf-2bdfecc2163e" /></a>  
  <a href="https://cocoapods.org/pods/SHDateFormatter"><img alt="Downloads" src="https://img.shields.io/cocoapods/dt/SHDateFormatter.svg?maxAge=3600&style=flat" /></a>
  <a href="https://www.paypal.me/STHEROLD"><img alt="Donate" src="https://img.shields.io/badge/Donate-PayPal-blue.svg"/></a>
</p>

This framework supports encoding as well as decoding many different date and time format. At the moment the follownig are supported (see SHDateFormat): 

* `shortWeekdayName`       => Sun, Mon, Tue, ...
* `longWeekdayName`        => Sunday, Monday, Tuesday, ...
* `shortTimeNoDate`        => 12:00 PM, 1:00 AM
* `noTimeShortDateNoYear`  => 12/31
* `noTimeShortDate`        => 12/02/2018
* `noTimeLongDate`         => December 2, 2018
* `noTimeRelativeDate`     => Today, Tomorrow, ...
* `ISO8601`                => "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"

The `ISO8601` format implements the standard for working with dates and times between client and server applications. A good explanation if this standard and how to work with it can be found in the [Apple Documenation](https://developer.apple.com/library/ios/qa/qa1480/_index.html) or on [Ole Begemanns Blog](http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-2/).

Additionally the following convenience functions are available on the SHDateFormatter sharedInstance which will return default values if the input date is nil. They allow to easily deal with optionals and can provide additional functionality like giving you a relative date instead of e.g. "yyyy/MM/dd":
* `localizedTimeStringFromDate(_:)` - will return `--:--` per default
* ... to be continued ...

## Requirements

The framework is compatible with Xcode 9 and Swift 4. The minimum version is iOS 8.

## Installation

SHDateFormatter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SHDateFormatter'
```

## Next Steps

* include more convenience functions to better support relative dates
* tests for string2date conversion
* support swift package manager and carthage

## Contribution

- If you found a **bug**, open an **issue**
- If you have a **feature request**, open an **issue**
- If you want to **contribute**, submit a **pull request**

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHDateFormatter is available under the MIT license. See the LICENSE file for more info.
