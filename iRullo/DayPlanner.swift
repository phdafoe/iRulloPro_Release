//
//  DayPlanner.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 12/1/24.
//

import Foundation

class DayPlanner: ObservableObject {
    
    @Published private var model = MyCalendar()
    @Published var taskDescription: String = ""
    
    var currentDate: Date {
        return model.currentDate
    }
    
    func setCurrentDate(to date: Date) {
        model.setCurrentDate(to: date)
    }
    
    func dates() -> [Date] {
        model.datesInYear()
    }
    
    func startDateOfWeekInAYear() -> [Date] {
        model.startDateOfWeeksInAYear()
    }
    
    func datesInAWeek(from date: Date) -> [Date] {
        model.dateInAWeek(from: date)
    }
    
    func starDateOfWeek(from date: Date) -> Date {
        model.startDayOfWeek(from: date)
    }
    
    func isCurrent(_ date: Date) -> Bool {
        return date == currentDate
    }
    
    func currentPositionInWeek() -> Int {
        let startOfWeek = starDateOfWeek(from: currentDate)
        let datesInAWeek = datesInAWeek(from: startOfWeek)
        let position = datesInAWeek.firstIndex(of: currentDate)!
        return position
    }
    
}
