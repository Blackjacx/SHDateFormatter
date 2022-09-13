import Foundation

enum Calendars {
    static let gregorian: Calendar = Calendar(identifier: .gregorian)
}

public enum SHDateFormat: String {
    case shortWeekday               = "EEE"
    case longWeekday                = "EEEE"
    case shortMonth                 = "MMM"
    case longMonth                  = "MMMM"
    case shortYear                  = "yy"
    case longYear                   = "yyyy"
    case shortYearMonth             = "MMM yy"
    case longYearMonth              = "MMMM yyyy"
    case shortTimeNoDate
    case shortTimeMediumDate
    case noTimeShortDateNoYear      = "d.M."
    case noTimeShortDate
    case noTimeLongDate
    /// - note: Ignores relative formatting
    case noTimeIso8601Date          = "YYYY'-'MM'-'dd"
    /**
     * We use the `ISO8601DateFormatter` since it is able to generate valid
     * dates from a range of ISO8601 date format strings.
     * http://oleb.net/blog/2011/11/working-with-date-and-time-in-cocoa-part-2/
     * https://developer.apple.com/library/ios/qa/qa1480/_index.html
     * - note: Ignores relative formatting
     */
    case ISO8601
}

public struct SHDateFormatter {

    public static let shared = SHDateFormatter()

    public static func is12hFormat(_ locale: Locale = Locale.current) -> Bool {

        let format = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)
        return format?.contains("a") == true
    }

    static let formatter = DateFormatter()
    static let iso8601Formatter = ISO8601DateFormatter()
    static let serialDispatchQueue = DispatchQueue(label: "com.dateFormatter.globalSerialDispatchQueue")

    private init() {}

    private func configureForDateFormat(format: SHDateFormat, locale: Locale?, timeZone: TimeZone?, needsRelativeFormatting: Bool) {
        reset()

        if locale != nil { SHDateFormatter.formatter.locale = locale }
        if timeZone != nil { SHDateFormatter.formatter.timeZone = timeZone }

        let locale = SHDateFormatter.formatter.locale

        switch format {
        case .shortWeekday, .longWeekday, .shortMonth, .longMonth, .longYear, .shortYear, .noTimeShortDateNoYear,
             .shortYearMonth, .longYearMonth:
            SHDateFormatter.formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format.rawValue,
                                                                            options: 0,
                                                                            locale: locale)

        case .shortTimeNoDate:
            SHDateFormatter.formatter.timeStyle = .short
            SHDateFormatter.formatter.dateStyle = .none

        case .shortTimeMediumDate:
            SHDateFormatter.formatter.timeStyle = .short
            SHDateFormatter.formatter.dateStyle = .medium

        case .noTimeShortDate:
            SHDateFormatter.formatter.timeStyle = .none
            SHDateFormatter.formatter.dateStyle = .short

        case .noTimeLongDate:
            SHDateFormatter.formatter.timeStyle = .none
            SHDateFormatter.formatter.dateStyle = .long

        case .noTimeIso8601Date:
            SHDateFormatter.formatter.locale = Locale(identifier: "en_US_POSIX")
            SHDateFormatter.formatter.dateFormat = format.rawValue

        case .ISO8601:
            break
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
        SHDateFormatter.formatter.locale = Locale.current
        SHDateFormatter.formatter.timeZone = TimeZone.current
    }

    /**
     * Converts a given Date to String using the provided format and locale. This method runs thread safe.
     *
     * - parameter date: Date string to convert from.
     * - parameter format: The format used for the conversion.
     * - parameter locale: The locale used for the conversion.
     * - parameter timeZone: The timeZone used for the conversion.
     * - parameter needsRelativeFormatting: Use relative formatting when set to true.
     * - returns: A String object representing the date.
     */
    public func string(from date: Date?,
                       format: SHDateFormat,
                       locale: Locale? = nil,
                       timeZone: TimeZone? = nil,
                       needsRelativeFormatting: Bool = false) -> String {
        var dateString: String = ""

        guard let date = date else {
            return dateString
        }

        switch format {
        case .shortWeekday, .longWeekday, .shortMonth, .longMonth, .shortYear,
                .longYear, .shortYearMonth, .longYearMonth, .shortTimeNoDate,
                .shortTimeMediumDate, .noTimeShortDateNoYear, .noTimeShortDate,
                .noTimeLongDate, .noTimeIso8601Date:

            SHDateFormatter.serialDispatchQueue.sync {
                configureForDateFormat(format: format,
                                       locale: locale,
                                       timeZone: timeZone,
                                       needsRelativeFormatting: needsRelativeFormatting)
                dateString = SHDateFormatter.formatter.string(from: date)
            }

        case .ISO8601:
            if !needsRelativeFormatting {
                dateString = Self.iso8601Formatter.string(from: date)
            }
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
    public func date(from string: String?,
                     format: SHDateFormat,
                     locale: Locale? = nil,
                     timeZone: TimeZone? = nil,
                     needsRelativeFormatting: Bool = false) -> Date? {
        var date: Date?

        guard let dateString = string else {
            return date
        }

        SHDateFormatter.serialDispatchQueue.sync {

            switch format {
            case .shortWeekday, .longWeekday, .shortMonth, .longMonth, .shortYear,
                    .longYear, .shortYearMonth, .longYearMonth, .shortTimeNoDate,
                    .shortTimeMediumDate, .noTimeShortDateNoYear, .noTimeShortDate,
                    .noTimeLongDate, .noTimeIso8601Date:

                configureForDateFormat(format: format,
                                       locale: locale,
                                       timeZone: timeZone,
                                       needsRelativeFormatting: needsRelativeFormatting)
                date = Self.formatter.date(from: dateString)

            case .ISO8601:
                date = Self.iso8601Formatter.date(from: dateString)
            }
        }
        return date
    }
}
