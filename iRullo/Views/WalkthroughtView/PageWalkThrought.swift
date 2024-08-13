//
//  PageWalkThrought.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/8/24.
//

import Foundation

enum Page: String, CaseIterable {
    case page1 = "figure.run"
    case page2 = "figure.handball"
    case page3 = "figure.open.water.swim"
    case page4 = "figure.tennis"
    
    var title: String {
        switch self {
        case .page1: "Welcome to PlayStation Title"
        case .page2: "Welcome to PlayStation 1 Title"
        case .page3: "Welcome to PlayStation 2 Title"
        case .page4: "Welcome to PlayStation 3 Title"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: "Welcome to PlayStation subtitle Welcome to PlayStation subtitle"
        case .page2: "Welcome to PlayStation Welcome to PlayStation subtitle 1"
        case .page3: "Welcome to PlayStation Welcome to PlayStation subtitle 2"
        case .page4: "Welcome to PlayStation Welcome to PlayStation subtitle 3"
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        }
    }
    
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < 4 {
            return Page.allCases[index]
        }
        return self
    }
    
    var previusPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
    
    
}
