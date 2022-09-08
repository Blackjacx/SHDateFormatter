//
//  SHDateFormatter+Additions.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 07/10/2016.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import Foundation

public extension SHDateFormatter {

    func localizedTimeStringFromDate(date: Date?) -> String {
        date.map { string(from: $0, format: .shortTimeNoDate) } ?? "--:--"
    }
}
