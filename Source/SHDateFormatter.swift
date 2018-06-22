//
//  SHDateFormatter.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 07/10/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import Foundation

struct Calendars {
    static let gregorian: Calendar = Calendar(identifier: .gregorian)
}

public enum SHDateFormat: String {
    case shortWeekdayName       = "EEE"
    case longWeekdayName        = "EEEE"
    case shortTimeNoDate
    case noTimeShortDateNoYear  = "d.M."
    case noTimeShortDate
    case noTimeLongDate
    /**
     * The only correct date format for client/server communication.
     * http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-2/
     * https://developer.apple.com/library/ios/qa/qa1480/_index.html
     */
    case ISO8601                = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
}

public struct SHDateFormatter {

    public static let shared = SHDateFormatter()

    static let formatter = DateFormatter()
    static let serialDispatchQueue = DispatchQueue(label: "com.dateFormatter.globalSerialDispatchQueue")

    private init() {}

    private func configureForDateFormat(format: SHDateFormat, locale: Locale?, timeZone: TimeZone?, needsRelativeFormatting: Bool) {
        reset()

        if locale != nil { SHDateFormatter.formatter.locale = locale }
        if timeZone != nil { SHDateFormatter.formatter.timeZone = timeZone }

        let locale = SHDateFormatter.formatter.locale

        switch format {
        case .shortWeekdayName: fallthrough
        case .longWeekdayName: fallthrough
        case .noTimeShortDateNoYear:
            SHDateFormatter.formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format.rawValue, options: 0, locale: locale)

        case .ISO8601:
            SHDateFormatter.formatter.locale = Locale(identifier: "en_US_POSIX")
            SHDateFormatter.formatter.dateFormat = format.rawValue
            SHDateFormatter.formatter.timeZone = TimeZone(secondsFromGMT: 0)

        case .shortTimeNoDate:
            SHDateFormatter.formatter.timeStyle = .short
            SHDateFormatter.formatter.dateStyle = .none

        case .noTimeShortDate:
            SHDateFormatter.formatter.timeStyle = .none
            SHDateFormatter.formatter.dateStyle = .short

        case .noTimeLongDate:
            SHDateFormatter.formatter.timeStyle = .none
            SHDateFormatter.formatter.dateStyle = .long
        }

        if needsRelativeFormatting {
            SHDateFormatter.formatter.doesRelativeDateFormatting = true
        }
    }

    func reset() {
        SHDateFormatter.formatter.formatterBehavior = .default
        SHDateFormatter.formatter.doesRelativeDateFormatting = false
        SHDateFormatter.formatter.dateFormat = nil
        SHDateFormatter.formatter.timeStyle = .none
        SHDateFormatter.formatter.dateStyle = .none
        // http://www.alexcurylo.com/2011/02/16/tip-nsdateformatter-localization/
        SHDateFormatter.formatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        SHDateFormatter.formatter.timeZone = TimeZone.current
    }

    /**
     * Converts a given Date to String using the provided format and locale. This method runs thread safe.
     *
     * - parameter date: Date string to convert from.
     * - parameter format: The format used for the conversion.
     * - parameter locale: The locale used for the conversion.
     * - parameter timeZone: The timeZone used for the conversion.
     * - parameter needsRelativeFormatting: Use relative formating when set to true.
     * - returns: A String object representing the date.
     */
    public func string(from date: Date?, format: SHDateFormat, locale: Locale? = nil, timeZone: TimeZone? = nil, needsRelatioveFormatting: Bool = false) -> String {
        var dateString: String = ""

        guard let date = date else {
            return dateString
        }

        SHDateFormatter.serialDispatchQueue.sync {
            configureForDateFormat(format: format,
                                   locale: locale,
                                   timeZone: timeZone,
                                   needsRelativeFormatting: needsRelatioveFormatting)
            dateString = SHDateFormatter.formatter.string(from: date)
        }
        return dateString
    }

    /**
     * Converts a given date String to Date using the provided format and locale. This method runs thread safe.
     *
     * - parameter string: Date string to convert from.
     * - parameter format: The format used for the conversion.
     * - parameter locale: The locale used for the conversion.
     * - parameter timeZone: The timeZone used for the conversion.
     * - parameter needsRelativeFormatting: Use relative formating when set to true.
     * - returns: A Date object representing the date.
     */
    public func date(from string: String?, format: SHDateFormat, locale: Locale? = nil, timeZone: TimeZone? = nil, needsRelativeFormatting: Bool = false) -> Date? {
        var date: Date?

        guard let dateString = string else {
            return date
        }

        SHDateFormatter.serialDispatchQueue.sync {
            configureForDateFormat(format: format,
                                   locale: locale,
                                   timeZone: timeZone,
                                   needsRelativeFormatting: needsRelativeFormatting)
            date = SHDateFormatter.formatter.date(from: dateString)
        }
        return date
    }
}
