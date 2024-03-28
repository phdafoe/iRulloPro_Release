//
//  MyPlanner.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/1/24.
//

import Foundation

struct Task: Identifiable, Hashable {
    var id = UUID()
    var taskDescription: String
}

struct MyPlanner{
    private var tasks = [Task]()
}

var testTask = [
    Task(taskDescription: "Answer Email"),
    Task(taskDescription: "Coffe time")
]

