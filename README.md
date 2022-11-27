<!-- <p align="center">
<img src="./icon.png" alt="Source" height="128" width="128">
</p> -->

# SHDateFormatter

<!-- [![Test](https://github.com/Blackjacx/SHDateFormatter/actions/workflows/test.yml/badge.svg)](https://github.com/Blackjacx/SHDateFormatter/actions/workflows/test.yml) -->
[![Twitter](https://img.shields.io/twitter/follow/blackjacxxx?label=%40Blackjacxxx)](https://twitter.com/blackjacxxx)
[![Github Current Release](https://img.shields.io/github/release/blackjacx/SHDateFormatter.svg)](https://github.com/blackjacx/SHDateFormatter/releases)
[![Swift Package Manager Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBlackjacx%2FSHDateFormatter%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Blackjacx/SHDateFormatter)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FBlackjacx%2FSHDateFormatter%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Blackjacx/SHDateFormatter)
[![Xcode 13+](https://img.shields.io/badge/Xcode-13%2B-blue.svg)](https://developer.apple.com/download/)
[![Codebeat](https://codebeat.co/badges/c74826a3-8f8b-41da-8daf-2bdfecc2163e)](https://codebeat.co/projects/github-com-blackjacx-shdateformatter-develop)
[![License](https://img.shields.io/github/license/blackjacx/SHDateFormatter.svg)](https://github.com/blackjacx/SHDateFormatter/blob/develop/LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.me/STHEROLD)

This framework supports encoding as well as decoding many different date and time format. At the moment the following are supported (see SHDateFormat): 

* `shortWeekday`            => Sun, Mon, Tue, ...
* `longWeekday`             => Sunday, Monday, Tuesday, ...
* `shortMonth`              => Jan, Feb, ...
* `longMonth`               => January, February, ...
* `shortTimeNoDate`         => 12:00 PM, 1:00 AM
* `shortTimeMediumDate`     => Jan 1, 2000 at 12:00 AM
* `noTimeShortDateNoYear`   => 12/31
* `noTimeShortDate`         => 12/02/2018
* `noTimeLongDate`          => December 2, 2018
* `noTimeRelativeDate`      => Today, Tomorrow, ...
* `ISO8601`                 => "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'" / "yyyy'-'MM'-'dd'T'HH':'mm':'ss'+01:00'" / etc. 

The `ISO8601` format implements the standard for working with dates and times between client and server applications. A good explanation if this standard and how to work with it can be found in the [Apple Documenation](https://developer.apple.com/library/ios/qa/qa1480/_index.html) or on [Ole Begemanns Blog](http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-2/).

Additionally the following convenience functions are available on the SHDateFormatter sharedInstance which will return default values if the input date is nil. They allow to easily deal with optionals and can provide additional functionality like giving you a relative date instead of e.g. "yyyy/MM/dd":
* `localizedTimeStringFromDate(_:)` - will return `--:--` per default
* ... to be continued ...

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

In Xcode open your target list and select your project. Click the tab `Swift  Packages` and there the small `+` icon. Enter the URL of this repository, select the version you want to install - usually the preset is okay - and confirm.

### [CocoaPods](http://cocoapods.org)

I dropped CocoaPods support in favor of SPM from version `1.7.0`. 
Please integrate the package via SPM (see above).

### Carthage

I dropped Carthage support in favor of SPM from version `1.7.0`. 
Please integrate the package via SPM (see above).

## Code Documentation

The [code documentation](https://swiftpackageindex.com/Blackjacx/SHDateFormatter/develop/documentation/shdateformatter) is generated and hosted by [Swift Package Index](https://swiftpackageindex.com/) (powered by [DocC](https://developer.apple.com/documentation/docc))

## Release

To release this Swift package the following steps have to be taken:
- Create a new branch `release-x.y.z`
- Run `bash <(curl -H -s https://raw.githubusercontent.com/Blackjacx/Scripts/master/frameworks/bootstrap.sh)` to update to the latest shared development files
- Run `bundle update` to update all Ruby gems
- Commit all changes, make a PR and merge it to develop
- Run `bundle exec fastlane release framework:"SHDateFormatter" version:"x.y.z"` to release the new version
- Post the following on Twitter
```
SHDateFormatter release x.y.z 🎉

▸ 🚀  SHDateFormatter (x.y.z) successfully published
▸ 📅  September 2nd
▸ 🌎  https://swiftpackageindex.com/Blackjacx/SHDateFormatter
▸ 🌎  https://github.com/Blackjacx/SHDateFormatter/releases/latest
▸ 👍  Tell your friends!

#SPM #Date #Formatter #tested
```

## Contribution

- If you found a **bug**, please open an **issue**.
- If you have a **feature request**, please open an **issue**.
- If you want to **contribute**, please submit a **pull request**.

## Author

[Stefan Herold](mailto:stefan.herold@gmail.com) • 🐦 [@Blackjacxxx](https://twitter.com/Blackjacxxx)

## Contributors

Thanks to all of you who are part of this:

<a href="https://github.com/blackjacx/SHDateFormatter/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=blackjacx/SHDateFormatter" />
</a>

## License

SHDateFormatter is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
