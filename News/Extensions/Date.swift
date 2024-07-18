//
//  Date.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

public extension Date {
    // MARK: - Initializers
    init(dateString: String, format: String, timeZone: TimeZone) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: dateString) else {
            self = Date()
            return
        }
        self = date
    }
    
    init(dateString: String, format: String) {
        self.init(dateString: dateString,
                  format: format,
                  timeZone: TimeZone.autoupdatingCurrent)
    }
    
    // MARK: - Public Methods
    func components(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func current(format: String = "E, MMM d") -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
