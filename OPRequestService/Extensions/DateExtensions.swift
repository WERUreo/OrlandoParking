//
//  DateExtensions.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 3/23/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import Foundation

extension Date
{
    public var calendar: Calendar
    {
        return Calendar.current
    }

    ////////////////////////////////////////////////////////////
    
    public init(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self = dateFormatter.date(from: iso8601String) ?? Date()
    }

    ////////////////////////////////////////////////////////////

    public func dateString(withFormat format: String = "YYYY-MM-dd") -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    ////////////////////////////////////////////////////////////

    public func adding(_ component: Calendar.Component, value: Int) -> Date {
        switch component {
        case .second:
            return calendar.date(byAdding: .second, value: value, to: self) ?? self

        case .minute:
            return calendar.date(byAdding: .minute, value: value, to: self) ?? self

        case .hour:
            return calendar.date(byAdding: .hour, value: value, to: self) ?? self

        case .day:
            return calendar.date(byAdding: .day, value: value, to: self) ?? self

        case .weekOfYear, .weekOfMonth:
            return calendar.date(byAdding: .day, value: value * 7, to: self) ?? self

        case .month:
            return calendar.date(byAdding: .month, value: value, to: self) ?? self
            
        case .year:
            return calendar.date(byAdding: .year, value: value, to: self) ?? self
            
        default:
            return self
        }
    }
}
