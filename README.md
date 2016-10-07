# SHDateFormatter

[![CI Status](http://img.shields.io/travis/Stefan Herold/SHDateFormatter.svg?style=flat)](https://travis-ci.org/Stefan Herold/SHDateFormatter)
[![Version](https://img.shields.io/cocoapods/v/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)
[![License](https://img.shields.io/cocoapods/l/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)
[![Platform](https://img.shields.io/cocoapods/p/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)

This framework supports encoding as well as decoding many different date and time format. At the moment the follownig are supported (see SHDateFormat): 

* `shortWeekdayName`       => Sun, Mon, Tue, ...
* `longWeekdayName`        => Sunday, Monday, Tuesday, ...
* `shortTimeNoDate`        => 12:00 PM, 1:00 AM
* `noTimeShortDateNoYear`  => 12/31
* `noTimeShortDate`        => 12/31/2016
* `noTimeLongDate`         => December 31, 2016
* `noTimeRelativeDate`     => Today, Tomorrow, ...
* `ISO8601`                => "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"

The `ISO8601` format implements the standard for working with dates and times between client and server applications. A good explanation if this standard and how to work with it can be found in the [Apple Documenation](https://developer.apple.com/library/ios/qa/qa1480/_index.html) or on [Ole Begemanns Blog](http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-2/).

Additionally the following convenience functions are available on the SHDateFormatter sharedInstance which return default values if the input date is nil:
* `localizedTimeStringFromDate(_:)` - will return `--:--` per default
* ... to be continued ...

## Requirements

The framework is written in Swift 3 and tested with iOS versions 9 and 10.

## Installation

SHDateFormatter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SHDateFormatter"
```

## Author

Stefan Herold, stefan.herold@gmail.com

## License

SHDateFormatter is available under the MIT license. See the LICENSE file for more info.
