//
//  Date+Utils.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 06.07.17.
//  Copyright © 2017 StefanHerold. All rights reserved.
//

import Foundation

struct DateConstants {
    static let dayInSeconds = 86400.0
}

extension Date {

    public func minus24Hours() -> Date {

        return addingTimeInterval(-DateConstants.dayInSeconds)
    }

    public func plus24Hours() -> Date {

        return addingTimeInterval(DateConstants.dayInSeconds)
    }
}
