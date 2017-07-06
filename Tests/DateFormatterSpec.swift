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

    static let timeZone = TimeZone(identifier: "GMT")!

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

    override func spec() {

        describe("DateFormatter") {

            it("Verifies that the time zome is Europe/Berlin") {
                expect(type(of: self).timeZone.identifier) == "GMT"
            }

            context("Test 2000/01/01/12:00am") {

                let testDate = type(of: self).dateFrom(year: 1999, month: 12, day: 31, hour: 23, min: 00, sec: 0) // 12 am a Saturday

                context("\(deDE_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: deDE_Locale)
                        expect(result) == "Sa"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: deDE_Locale)
                        expect(result) == "Samstag"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale)
                        expect(result) == "00:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale)
                        expect(result) == "1.1."
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: deDE_Locale)
                        expect(result) == "1.1.00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: deDE_Locale)
                        expect(result) == "1. Januar 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale)
                        expect(result) == "1. Januar 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: deDE_Locale)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: enEN_Locale)
                        expect(result) == "Sat"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: enEN_Locale)
                        expect(result) == "Saturday"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale)
                        expect(result) == "12:00 AM"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale)
                        expect(result) == "1/1"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: enEN_Locale)
                        expect(result) == "1/1/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: enEN_Locale)
                        expect(result) == "January 1, 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale)
                        expect(result) == "January 1, 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: enEN_Locale)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: frFR_Locale)
                        expect(result) == "sam."
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: frFR_Locale)
                        expect(result) == "samedi"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale)
                        expect(result) == "00:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale)
                        expect(result) == "01/01"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: frFR_Locale)
                        expect(result) == "01/01/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: frFR_Locale)
                        expect(result) == "1 janvier 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale)
                        expect(result) == "1 janvier 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: frFR_Locale)
                        expect(result) == "1999-12-31T23:00:00Z"
                    }
                }
            }

            context("Test 2000/01/02/12:00pm") {

                let testDate = type(of: self).dateFrom(year: 2000, month: 1, day: 2, hour: 11, min: 0, sec: 0) // 12 pm a Sunday

                context("\(deDE_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: deDE_Locale)
                        expect(result) == "So"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: deDE_Locale)
                        expect(result) == "Sonntag"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale)
                        expect(result) == "2.1."
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: deDE_Locale)
                        expect(result) == "2.1.00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: deDE_Locale)
                        expect(result) == "2. Januar 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale)
                        expect(result) == "2. Januar 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: deDE_Locale)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: enEN_Locale)
                        expect(result) == "Sun"
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: enEN_Locale)
                        expect(result) == "Sunday"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale)
                        expect(result) == "1/2"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: enEN_Locale)
                        expect(result) == "1/2/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: enEN_Locale)
                        expect(result) == "January 2, 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale)
                        expect(result) == "January 2, 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: enEN_Locale)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortWeekdayName, locale: frFR_Locale)
                        expect(result) == "dim."
                    }

                    it("LongWeekdayName") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .longWeekdayName, locale: frFR_Locale)
                        expect(result) == "dimanche"
                    }

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeShortDateNoYear") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale)
                        expect(result) == "02/01"
                    }

                    it("NoTimeShortDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeShortDate, locale: frFR_Locale)
                        expect(result) == "02/01/00"
                    }

                    it("NoTimeLongDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeLongDate, locale: frFR_Locale)
                        expect(result) == "2 janvier 2000"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale)
                        expect(result) == "2 janvier 2000"
                    }

                    it("ISO8601") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .ISO8601, locale: frFR_Locale)
                        expect(result) == "2000-01-02T11:00:00Z"
                    }
                }
            }

            context("Test Yesterday Noon") {

                let testDate = type(of: self).yesterdayNoon()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale)
                        expect(result) == "Gestern"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale)
                        expect(result) == "Yesterday"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale)
                        expect(result) == "hier"
                    }
                }
            }

            context("Test Today Noon") {

                let testDate = type(of: self).todayNoon()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale)
                        expect(result) == "Heute"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale)
                        expect(result) == "Today"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale)
                        expect(result) == "aujourd’hui"
                    }
                }
            }

            context("Test Tomorrow Noon") {

                let testDate = type(of: self).tomorrowNoon()

                context("\(deDE_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: deDE_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: deDE_Locale)
                        expect(result) == "Morgen"
                    }
                }

                context("\(enEN_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: enEN_Locale)
                        expect(result) == "12:00 PM"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: enEN_Locale)
                        expect(result) == "Tomorrow"
                    }
                }

                context("\(frFR_Locale.identifier)") {

                    it("ShortTimeNoDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .shortTimeNoDate, locale: frFR_Locale)
                        expect(result) == "12:00"
                    }

                    it("NoTimeRelativeDate") {
                        let result = SHDateFormatter.shared.stringFromDate(date: testDate, format: .noTimeRelativeDate, locale: frFR_Locale)
                        expect(result) == "demain"
                    }
                }
            }
        }
    }
}
