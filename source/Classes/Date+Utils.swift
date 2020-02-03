//
//  Date+Utils.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 06.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import Foundation

enum DateConstants {
    static let dayInSeconds = 86400.0
}

public extension Date {

    func minus24Hours() -> Date {
        addingTimeInterval(-DateConstants.dayInSeconds)
    }

    func plus24Hours() -> Date {
        addingTimeInterval(DateConstants.dayInSeconds)
    }
}
