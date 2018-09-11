//
//  DateTimeFormatter.swift
//  DieselApp
//
//  Created by Gudisi, Manjunath on 08/06/18.
//  Copyright © 2018 Narayan. All rights reserved.
//

import Foundation

class DateTimeFormatter {
    
    static var DATE_FORMAT_TO_SEND_TO_BACKEND = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    static var BACKEND_ORDER_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
    static var NEW_DATE_FORMAT_TO_SEND_TO_BACKEND = "yyyy-MM-dd"
    static var DATE_FORMAT_TO_SHOW_ON_UI = "dd-MM-yyyy"
    
    static let dateFormatterWithoutTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SHOW_ON_UI
        return formatter
    }()
    
    static let dateFormatterWithoutTimeWithDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd-MM-yyyy"
        return formatter
    }()
    
    static let dateFormatterWithTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter
    }()
    
    static let onlyTimeFormate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static func today() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SEND_TO_BACKEND
        return dateFormatter.string(from: Date())
    }
    
    static func todayWithTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        return dateFormatter.string(from: Date())
    }
    
    static func todayDate() -> Date? {
        return Date()
    }
    
    static func tomorrow() -> Date? {
        return Date(timeIntervalSinceNow: 86400)
    }
    
    static func next5Days() -> Date? {
        return Date(timeIntervalSinceNow: 432000)
    }
    
    static func numberOfDays(from startDate:Date, to endDate:Date) -> Int {
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
    
    static func backendFormatDate(from string:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SEND_TO_BACKEND
        return dateFormatter.date(from: string)
    }
    
    static func orderFormatDate(from string:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormatter.BACKEND_ORDER_DATE_FORMAT
        return dateFormatter.date(from: string)
    }
    
    static func convertToBackendDate(from uiDate: String?) -> String? {
        guard uiDate == nil || (uiDate?.count)! <= 0 else {
            let date = DateTimeFormatter.dateFormatterWithoutTime.date(from: uiDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SEND_TO_BACKEND
            return dateFormatter.string(from: date!)
        }
        return "UNKNOWN"
    }
    
    static func convertToNewBackendDate(from uiDate: String?) -> String? {
        guard uiDate == nil || (uiDate?.count)! <= 0 else {
            let date = DateTimeFormatter.dateFormatterWithoutTime.date(from: uiDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormatter.NEW_DATE_FORMAT_TO_SEND_TO_BACKEND
            return dateFormatter.string(from: date!)
        }
        return "UNKNOWN"
    }
    
    static func convertToUIDate(from backendDate: String?) -> String? {
        guard backendDate == nil || (backendDate?.count)! <= 0 else {
            if let date = DateTimeFormatter.backendFormatDate(from: backendDate!) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SHOW_ON_UI
                return dateFormatter.string(from: date)
            }
            return "UNKNOWN"
        }
        return "UNKNOWN"
    }
    
    static func convertToOrderScreenUIDate(from backendDate: String?) -> String? {
        guard backendDate == nil || (backendDate?.count)! <= 0 else {
            if let date = DateTimeFormatter.orderFormatDate(from: backendDate!) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateTimeFormatter.DATE_FORMAT_TO_SHOW_ON_UI
                return dateFormatter.string(from: date)
            }
            return "UNKNOWN"
        }
        return "UNKNOWN"
    }
    
    static func convertToDownloadStatementsDate(from uiDate: String?) -> String? {
        guard uiDate == nil || (uiDate?.count)! <= 0 else {
            let date = DateTimeFormatter.dateFormatterWithoutTime.date(from: uiDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date!)
        }
        return "UNKNOWN"
    }
}

extension Date {
    
    func getDateBy(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }
    
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }
    
    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }
    
    func getLastMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getYesterday() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    
    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    // This Month Start
    func getThisMonthStart() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    //Last Month Start
    func getLastMonthStart() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    //Last Month End
    func getLastMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
}
