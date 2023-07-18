import XCTest
import Quick
import Nimble
@testable import SHDateFormatter

// swiftlint:disable:next type_body_length
final class DateFormatterTests: QuickSpec {

    // swiftlint:disable:next function_body_length
    override func spec() {

        let gmtZone = TimeZone.GMT

        let deDELocale = Locale(identifier: "de_DE")
        let enUSLocale = Locale(identifier: "en_US")
        let frFRLocale = Locale(identifier: "fr_FR")

        var testDate: Date = Date()

        describe("DateFormatter") {

            func dateFrom(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {

                // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
                let comps = DateComponents(
                    calendar: Calendars.gregorian,
                    timeZone: gmtZone,
                    year: year,
                    month: month,
                    day: day,
                    hour: hour,
                    minute: min,
                    second: sec)
                return comps.date!
            }

            func todayNoon() -> Date {
                let calendar = Calendars.gregorian
                let nowComps = calendar.dateComponents(in: gmtZone, from: Date())

                // Constructing dates correctly: http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-1/
                let comps = DateComponents(
                    calendar: Calendars.gregorian,
                    timeZone: gmtZone,
                    year: nowComps.year,
                    month: nowComps.month,
                    day: nowComps.day,
                    hour: 12)
                return comps.date!
            }

            context("12h format") {

                it("uses 12h format for locale en_US") {
                    expect(SHDateFormatter.is12hFormat(enUSLocale)) == true
                }

                it("uses 24h format for locale de_DE") {
                    expect(SHDateFormatter.is12hFormat(deDELocale)) == false
                }

                it("uses 24h format for locale fr_FR") {
                    expect(SHDateFormatter.is12hFormat(frFRLocale)) == false
                }
            }

            context("String To Date") {

                context("General Tests") {

                    it("returns a nil date the input string is nil") {
                        let result = SHDateFormatter.shared.date(from: nil, format: .shortWeekday)
                        expect(result).to(beNil())
                    }
                }
            }

            context("Date To String") {

                context("General Tests") {

                    it("returns an empty string the input date is nil") {
                        let result = SHDateFormatter.shared.string(from: nil, format: .shortWeekday)
                        expect(result) == ""
                    }
                }

                context("Test 2000/01/01/12:00am") {

                    beforeEach {
                        // 12 am a Saturday with DST
                        testDate = dateFrom(year: 2000,
                                            month: 1,
                                            day: 1,
                                            hour: 0,
                                            min: 0,
                                            sec: 0)
                    }

                    context("\(deDELocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Sa"
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Samstag"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan"
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Januar"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }

                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01.00"
                        }
                        
                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00:00"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01.01.2000, 00:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1.1."
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01.01.00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1. Januar 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01T00:00:00Z"
                        }
                    }

                    context("\(enUSLocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Sat"
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Saturday"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan"
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "January"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }
                        
                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/00"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "12:00 AM"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan 1, 2000 at 12:00 AM"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1/1"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1/1/00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "January 1, 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01T00:00:00Z"
                        }
                    }

                    context("\(frFRLocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "sam."
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "samedi"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "janv."
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "janvier"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }
                        
                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/00"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00:00"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1 janv. 2000 à 00:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/01"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/01/2000"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1 janvier 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-01T00:00:00Z"
                        }
                    }
                }

                context("Test 2000/01/02/12:00pm") {

                    beforeEach {
                        // 12 pm a Sunday
                        testDate = dateFrom(year: 2000,
                                            month: 1,
                                            day: 2,
                                            hour: 12,
                                            min: 0,
                                            sec: 0)
                    }

                    context("\(deDELocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "So"
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Sonntag"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan"
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Januar"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }
                        
                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01.00"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "12:00"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "02.01.2000, 12:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2.1."
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "02.01.00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2. Januar 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: deDELocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02T12:00:00Z"
                        }
                    }

                    context("\(enUSLocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Sun"
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Sunday"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan"
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "January"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }
                        
                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/00"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "12:00 PM"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "Jan 2, 2000 at 12:00 PM"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1/2"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "1/2/00"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "January 2, 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: enUSLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02T12:00:00Z"
                        }
                    }

                    context("\(frFRLocale.identifier)") {

                        it("ShortWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortWeekday,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "dim."
                        }

                        it("LongWeekday") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longWeekday,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "dimanche"
                        }

                        it("ShortMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortMonth,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "janv."
                        }

                        it("LongMonth") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longMonth,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "janvier"
                        }

                        it("ShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "00"
                        }

                        it("LongYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .longYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000"
                        }
                        
                        it("NoDayShortMonthShortYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noDayShortMonthShortYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "01/00"
                        }

                        it("ShortTimeNoDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeNoDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "12:00"
                        }

                        it("ShortTimeMediumDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .shortTimeMediumDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2 janv. 2000 à 12:00"
                        }

                        it("NoTimeShortDateNoYear") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDateNoYear,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "02/01"
                        }

                        it("NoTimeShortDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeShortDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "02/01/2000"
                        }

                        it("NoTimeLongDate") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeLongDate,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2 janvier 2000"
                        }

                        it("NoTimeIso8601Date") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .noTimeIso8601Date,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02"
                        }

                        it("ISO8601") {
                            let result = SHDateFormatter.shared.string(from: testDate,
                                                                       format: .ISO8601,
                                                                       locale: frFRLocale,
                                                                       timeZone: gmtZone)
                            expect(result) == "2000-01-02T12:00:00Z"
                        }
                    }
                }

                context("Test Relative Date Formatting") {

                    context("Yesterday Noon") {

                        beforeEach {
                            testDate = todayNoon().minus24Hours()
                        }

                        context("\(deDELocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone, needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Gestern, 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Gestern"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Gestern"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enUSLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Yesterday at 12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Yesterday"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Yesterday"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFRLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "hier à 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "hier"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "hier"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }

                    context("Today Noon") {

                        beforeEach {
                            testDate = todayNoon()
                        }

                        context("\(deDELocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Heute, 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Heute"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Heute"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enUSLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Today at 12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Today"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Today"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFRLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "aujourd’hui à 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "aujourd’hui"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "aujourd’hui"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }

                    context("Tomorrow Noon") {

                        beforeEach {
                            testDate = todayNoon().plus24Hours()
                        }

                        context("\(deDELocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Morgen, 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Morgen"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Morgen"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: deDELocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(enUSLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00 PM"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Tomorrow at 12:00 PM"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Tomorrow"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "Tomorrow"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: enUSLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }

                        context("\(frFRLocale.identifier)") {

                            it("ShortWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("LongWeekday") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .longWeekday,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ShortTimeNoDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeNoDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "12:00"
                            }

                            it("ShortTimeMediumDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .shortTimeMediumDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "demain à 12:00"
                            }

                            it("NoTimeShortDateNoYear") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDateNoYear,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("NoTimeShortDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeShortDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "demain"
                            }

                            it("NoTimeLongDate") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeLongDate,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == "demain"
                            }

                            it("NoTimeIso8601Date") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .noTimeIso8601Date,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }

                            it("ISO8601") {
                                let result = SHDateFormatter.shared.string(from: testDate,
                                                                           format: .ISO8601,
                                                                           locale: frFRLocale,
                                                                           timeZone: gmtZone,
                                                                           needsRelativeFormatting: true)
                                expect(result) == ""
                            }
                        }
                    }
                }
            }
        }
    }
}
