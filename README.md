# SHDateFormatter

[![CI Status](http://img.shields.io/travis/Stefan Herold/SHDateFormatter.svg?style=flat)](https://travis-ci.org/Stefan Herold/SHDateFormatter)
[![Version](https://img.shields.io/cocoapods/v/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)
[![License](https://img.shields.io/cocoapods/l/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)
[![Platform](https://img.shields.io/cocoapods/p/SHDateFormatter.svg?style=flat)](http://cocoapods.org/pods/SHDateFormatter)

## Example

At the moment the date formatter supports teh following date and time formats:
* shortWeekdayName       => Sun, Mon, Tue, ...
* longWeekdayName        => Sunday, Monday, Tuesday, ...
* shortTimeNoDate        => 12:00 PM, 1:00 AM
* noTimeShortDateNoYear  => 12/31
* noTimeShortDate        => 12/31/2016
* noTimeLongDate         => December 31, 2016
* noTimeRelativeDate     => Today, Tomorrow, ...
* ISO8601                => "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"

## Requirements

The lib is tested with iOS version 9 and 10.

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
