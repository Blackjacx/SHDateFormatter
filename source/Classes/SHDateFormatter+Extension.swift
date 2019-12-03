//
//  SHDateFormatter+Additions.swift
//  SHDateFormatter
//
//  Created by Stefan Herold on 07/10/2016.
//  Copyright © 2016 StefanHerold. All rights reserved.
//

import Foundation

extension SHDateFormatter {
    
    public func localizedTimeStringFromDate(date: Date?) -> String {
        date.map { string(from: $0, format: .shortTimeNoDate) } ?? "--:--"
    }
}
