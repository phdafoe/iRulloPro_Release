//
//  MyCalendar.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/1/24.
//

import Foundation

struct MyCalendar {
    private (set) var today = Date()
    private (set) var currentDate: Date
    private var calendar = Calendar(identifier: .iso8601)
    private let dateFormatter = DateFormatter()
    private var startOfYear: Date
    
    init() {
        calendar.timeZone = TimeZone(identifier: "UTC")!
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let todayString = dateFormatter.string(from: today)
        currentDate = dateFormatter.date(from: todayString)!
        
        let currentYear = calendar.component(.year, from: currentDate)
        startOfYear = calendar.date(from: DateComponents(year:currentYear, month: 1, day: 1))!
    }
    
    mutating func setCurrentDate(to date: Date) {
        let dateString = dateFormatter.string(from: date)
        currentDate = dateFormatter.date(from: dateString)!
    }
    
    func datesInYear() -> [Date] {
        let range = calendar.range(of: .day, in: .year, for: startOfYear)!
        let datesArrInYear = range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: startOfYear)!
        }
        return datesArrInYear
    }
    
    func dateInAWeek(from date: Date) -> [Date] {
        let range = calendar.range(of: .weekday, in: .weekOfYear, for: date)!
        let dateArrInWeek = range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: date)
        }
        return dateArrInWeek
    }
    
    func startDateOfWeeksInAYear() -> [Date] {
        let currentWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfYear)
        let startOfweek = calendar.date(from: currentWeek)
        let range = calendar.range(of: .weekOfYear, in: .year, for: startOfYear)!
        let startOfWeekArr = range.compactMap {
            calendar.date(byAdding: .weekOfYear, value: $0, to: startOfweek!)
        }
        return startOfWeekArr
    }
    
    func startDayOfWeek(from date: Date) -> Date {
        let currentWeek = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: currentWeek)!
    }
}

extension Date {
    func monthYYYY() -> String {
        return self.formatted(.dateTime .month(.wide) .year())
    }
    
    func weekDayAbbrev() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated))
    }
    
    func dayNum() -> String {
        return self.formatted(.dateTime .day())
    }
}
