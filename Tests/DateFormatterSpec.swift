//
//  DateFormatterSpec.swift
//  Tests
//
//  Created by Stefan Herold on 07/10/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import SHDateFormatter

class DateFormatterSpec: QuickSpec {
    static let timeZone = TimeZone(identifier: "Europe/Berlin")!

    static func dateFrom(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {
        // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
        let components: DateComponents = {
            var comps: DateComponents = DateComponents()
            comps.calendar =  Calendars.gregorian
            comps.year = year
            comps.month = month
            comps.day = day
            comps.hour = hour
            comps.minute = min
            comps.second = sec
            comps.timeZone = timeZone
            return comps
        }()
        let date = Calendars.gregorian.date(from: components)
        return date!
    }

    static func yesterdayNoon() -> Date {
        let date = todayNoon().addingTimeInterval(-86400)
        return date
    }

    static func todayNoon() -> Date {
        var components = Calendars.gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        components.hour = 12
        components.minute = 0
        let date = Calendars.gregorian.date(from: components)
        return date!
    }

    static func tomorrowNoon() -> Date {
        let date = todayNoon().addingTimeInterval(86400)
        return date
    }

    var isDST: Bool {
        return type(of: self).timeZone.isDaylightSavingTime()
    }

    lazy var testDates: [Date] = {
        return [
            DateFormatterSpec.dateFrom(year: 2000, month: 1, day: 1, hour: 0, min: 0, sec: 0), // 12 am a Saturday
            DateFormatterSpec.dateFrom(year: 2000, month: 1, day: 2, hour: 12, min: 0, sec: 0), // 12 pm a Sunday
            DateFormatterSpec.yesterdayNoon(),
            DateFormatterSpec.todayNoon(),
            DateFormatterSpec.tomorrowNoon(),
        ]
    }()

    override func spec() {

        let expectationsForDate: [Date : [String : [SHDateFormat : String]]] = [
            /*
             * Testing relative date midnight
             */
            testDates[0] : [
                "de_DE" : [
                    .shortWeekdayName:          isDST ? "Sa" : "Fr",
                    .longWeekdayName:           "Samstag",
                    .shortTimeNoDate:           "00:00",
                    .noTimeShortDateNoYear :    "1.1.",
                    .noTimeShortDate:           "1.1.00",
                    .noTimeLongDate:            "1. Januar 2000",
                    .noTimeRelativeDate:        "1. Januar 2000",
                    .ISO8601:                   "1999-12-31T23:00:00Z",
                ],

                "en_EN" : [
                    .shortWeekdayName:          "Sat",
                    .longWeekdayName:           "Saturday",
                    .shortTimeNoDate:           "12:00 AM",
                    .noTimeShortDateNoYear :    "1/1",
                    .noTimeShortDate:           "1/1/00",
                    .noTimeLongDate:            "January 1, 2000",
                    .noTimeRelativeDate:        "January 1, 2000",
                    .ISO8601:                   "1999-12-31T23:00:00Z",
                ],

                "fr_FR" : [
                    .shortWeekdayName:          "sam.",
                    .longWeekdayName:           "samedi",
                    .shortTimeNoDate:           "00:00",
                    .noTimeShortDateNoYear :    "01/01",
                    .noTimeShortDate:           "01/01/00",
                    .noTimeLongDate:            "1 janvier 2000",
                    .noTimeRelativeDate:        "1 janvier 2000",
                    .ISO8601:                   "1999-12-31T23:00:00Z",
                ],
            ],

            /*
             * Testing noon
             */
            testDates[1] : [
                "de_DE" : [
                    .shortWeekdayName:          "So",
                    .longWeekdayName:           "Sonntag",
                    .shortTimeNoDate:           "12:00",
                    .noTimeShortDateNoYear :    "2.1.",
                    .noTimeShortDate:           "2.1.00",
                    .noTimeLongDate:            "2. Januar 2000",
                    .noTimeRelativeDate:        "2. Januar 2000",
                    .ISO8601:                   "2000-01-02T11:00:00Z",
                ],

                "en_EN" : [
                    .shortWeekdayName:          "Sun",
                    .longWeekdayName:           "Sunday",
                    .shortTimeNoDate:           "12:00 PM",
                    .noTimeShortDateNoYear :    "1/2",
                    .noTimeShortDate:           "1/2/00",
                    .noTimeLongDate:            "January 2, 2000",
                    .noTimeRelativeDate:        "January 2, 2000",
                    .ISO8601:                   "2000-01-02T11:00:00Z",
                ],

                "fr_FR" : [
                    .shortWeekdayName:          "dim.",
                    .longWeekdayName:           "dimanche",
                    .shortTimeNoDate:           "12:00",
                    .noTimeShortDateNoYear :    "02/01",
                    .noTimeShortDate:           "02/01/00",
                    .noTimeLongDate:            "2 janvier 2000",
                    .noTimeRelativeDate:        "2 janvier 2000",
                    .ISO8601:                   "2000-01-02T11:00:00Z",
                ],
            ],

            /*
             * Testing relative date yesterday
             */
            testDates[2] : [
                "de_DE" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "Gestern",
                ],

                "en_EN" : [
                    .shortTimeNoDate:           "12:00 PM",
                    .noTimeRelativeDate:        "Yesterday",
                ],

                "fr_FR" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "hier",
                ],
            ],

            /*
             * Testing relative date today
             */
            testDates[3] : [
                "de_DE" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "Heute",
                ],

                "en_EN" : [
                    .shortTimeNoDate:           "12:00 PM",
                    .noTimeRelativeDate:        "Today",
                ],

                "fr_FR" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "aujourd’hui",
                ],
            ],

            /*
             * Testing relative date tomorrow
             */
            testDates[4] : [
                "de_DE" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "Morgen",
                ],

                "en_EN" : [
                    .shortTimeNoDate:           "12:00 PM",
                    .noTimeRelativeDate:        "Tomorrow",
                ],

                "fr_FR" : [
                    .shortTimeNoDate:           "12:00",
                    .noTimeRelativeDate:        "demain",
                ],
            ],
        ]

        describe("dateFormatter") {

            context("for all locales") {
                it("formats dates correctly") {
                    for (testDate, expectationsForLocaleID) in expectationsForDate {
                        for (localeID, expectationsForFormat) in expectationsForLocaleID {
                            for (format, expectation) in expectationsForFormat {
                                let locale = Locale(identifier: localeID)
                                let actualResult = SHDateFormatter.sharedInstance.stringFromDate(date: testDate, format: format, locale: locale)
                                XCTAssertEqual(actualResult, expectation, "Failed for locale '\(localeID)' format '\(format)' and testDate '\(testDate)'")
                            }
                        }
                    }
                }
            }
        }
    }
}
