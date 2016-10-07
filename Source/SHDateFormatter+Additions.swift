//
//  SHDateFormatter+Additions.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 07/10/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import Foundation

extension SHDateFormatter {

    func localizedTimeStringFromDate(date: Date?) -> String {
        guard let date = date else {
            return "--:--"
        }
        return stringFromDate(date: date, format: .shortTimeNoDate)
    }
}
