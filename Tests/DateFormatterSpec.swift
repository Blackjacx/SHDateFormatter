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

    override func spec() {

        describe("DateFormatter") {

            let timeZone = TimeZone(identifier: "Europe/Berlin")!

            let deDE_Locale = Locale(identifier: "de_DE")
            let enEN_Locale = Locale(identifier: "en_EN")
            let frFR_Locale = Locale(identifier: "fr_FR")

            func dateFrom(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {

                // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
                let comps = DateComponents(
                    calendar: Calendars.gregorian,
                    timeZone: timeZone,
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
                    timeZone: timeZone,
                    year: now.year,
                    month: now.month,
                    day: now.day,
                    hour: 12)
                return comps.date!
            }

            it("Verifies that the time zone used for formatting is Europe/Berlin") {
                expect(timeZone.identifier) == "Europe/Berlin"
            }

            context("String To Date") {

                context("General Tests") {

                    it("returns a nil date the input string is nil") {
                        let result = SHDateFormatter.shared.date(from: nil, format: .shortWeekdayName)
                        expect(result).to(beNil())
                    }
                }
            }

            context("Date To String") {

                context("General Tests") {

                    it("returns an empty string the input date is nil") {
                        let result = SHDateFormatter.shared.string(from: nil, format: .shortWeekdayName)
                        expect(result) == ""
                    }
                }

                context("Test 2000/01/01/12:00am") {

                    let testDate = dateFrom(year: 2000, month: 1, day: 1, hour: 0, min: 0, sec: 0) // 12 am a Saturday with DST

                    context("\(deDE_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "Sa"
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "Samstag"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "00:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "1.1."
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "01.01.00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "1. Januar 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "1999-12-31T23:00:00Z"
                        }
                    }

                    context("\(enEN_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "Sat"
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "Saturday"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "12:00 AM"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "1/1"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "1/1/00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "January 1, 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "1999-12-31T23:00:00Z"
                        }
                    }

                    context("\(frFR_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "sam."
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "samedi"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "00:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "01/01"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "01/01/2000"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "1 janvier 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "1999-12-31T23:00:00Z"
                        }
                    }
                }

                context("Test 2000/01/02/12:00pm") {

                    let testDate = dateFrom(year: 2000, month: 1, day: 2, hour: 12, min: 0, sec: 0) // 12 pm a Sunday

                    context("\(deDE_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "So"
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "Sonntag"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "12:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "2.1."
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "02.01.00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "2. Januar 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: timeZone)
                            expect(result) == "2000-01-02T11:00:00Z"
                        }
                    }

                    context("\(enEN_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "Sun"
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "Sunday"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "12:00 PM"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "1/2"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "1/2/00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "January 2, 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: timeZone)
                            expect(result) == "2000-01-02T11:00:00Z"
                        }
                    }

                    context("\(frFR_Locale.identifier)") {

                        it("ShortWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "dim."
                        }

                        it("LongWeekdayName") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "dimanche"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "12:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "02/01"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "02/01/2000"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "2 janvier 2000"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: timeZone)
                            expect(result) == "2000-01-02T11:00:00Z"
                        }
                    }
                }

                context("Test Relative Date Formatting") {

                    context("Yesterday Noon") {

                        let testDate = todayNoon().minus24Hours()

                        context("\(deDE_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Gestern"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Gestern"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enEN_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Yesterday"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Yesterday"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFR_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "hier"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "hier"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }

                    context("Today Noon") {

                        let testDate = todayNoon()

                        context("\(deDE_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Heute"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Heute"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enEN_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Today"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Today"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFR_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "aujourd’hui"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "aujourd’hui"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }

                    context("Tomorrow Noon") {

                        let testDate = todayNoon().plus24Hours()

                        context("\(deDE_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Morgen"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Morgen"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: deDE_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enEN_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Tomorrow"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "Tomorrow"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: enEN_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFR_Locale.identifier)") {

                            it("ShortWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekdayName") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .longWeekdayName, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .shortTimeNoDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDateNoYear, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeShortDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "demain"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .noTimeLongDate, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == "demain"
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate, format: .ISO8601, locale: frFR_Locale, timeZone: timeZone, needsRelatioveFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }
                }

            }
        }
    }
}
