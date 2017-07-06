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

let deDE_Locale = Locale(identifier: "de_DE")
let enEN_Locale = Locale(identifier: "en_EN")
let frFR_Locale = Locale(identifier: "fr_FR")

class DateFormatterSpec: QuickSpec {

    override func spec() {

        describe("DateFormatter") {

            let formattingTimeZone = TimeZone(identifier: "Europe/Berlin")!
            let dateCreationTimeZone = TimeZone(identifier: "GMT")!

            func dateFrom(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {

                // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
                let comps = DateComponents(
                    calendar: Calendars.gregorian,
                    timeZone: dateCreationTimeZone,
                    year: year,
                    month: month,
                    day: day,
                    hour: hour,
                    minute: min,
                    second: sec)
                return comps.date!
            }

            func todayNoon() -> Date {

                var now = Calendars.gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
                let comps = DateComponents(
                    calendar: Calendars.gregorian,
                    timeZone: dateCreationTimeZone,
                    year: now.year,
                    month: now.month,
                    day: now.day,
                    hour: 12)
                return comps.date!
            }

            it("Verifies that the time zome used for date creation is GMT") {
                expect(dateCreationTimeZone.identifier) == "GMT"
            }

            it("Verifies that the time zome used for formatting is Europe/Berlin") {
                expect(formattingTimeZone.identifier) == "Europe/Berlin"
            }

            context("Test 2000/01/01/12:00am") {

                let testDate = dateFrom(year: 1999, month: 12, day: 31, hour: 23, min: 00, sec: 0) // 12 am a Saturday

                context("\(deDE_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Sa"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Samstag"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "00:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1.1."
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1.1.00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1. Januar 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1. Januar 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Sat"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Saturday"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00 AM"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1/1"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1/1/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "January 1, 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "January 1, 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "sam."
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "samedi"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "00:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "01/01"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "01/01/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1 janvier 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1 janvier 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }
            }

            context("Test 2000/01/02/12:00pm") {

                let testDate = dateFrom(year: 2000, month: 1, day: 2, hour: 11, min: 0, sec: 0) // 12 pm a Sunday

                context("\(deDE_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "So"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Sonntag"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2.1."
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2.1.00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2. Januar 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2. Januar 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Sun"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Sunday"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1/2"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "1/2/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "January 2, 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "January 2, 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "dim."
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "dimanche"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "02/01"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "02/01/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2 janvier 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2 janvier 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }
            }

            context("Test Yesterday Noon") {

                let testDate = todayNoon().minus24Hours()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Gestern"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Yesterday"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "hier"
                    }
                }
            }

            context("Test Today Noon") {

                let testDate = todayNoon()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Heute"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Today"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "aujourd’hui"
                    }
                }
            }

            context("Test Tomorrow Noon") {

                let testDate = todayNoon().plus24Hours()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Morgen"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale, timeZone: formattingTimeZone)
                        expect(result) == "Tomorrow"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale, timeZone: formattingTimeZone)
                        expect(result) == "demain"
                    }
                }
            }
        }
    }
}
