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
        case .page1: "Bienvenidos a iRullo"
        case .page2: "Si eres de los que le gusta correr o mas bien ver correr ?"
        case .page3: "Te gusta nadar? en aguas abiertas o en piscina?"
        case .page4: "Eres de los que se queda mirando hasta el útimo tiebreak ??"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: "iRullo es un gran portal de noticias deportivas que te permite estar al día"
        case .page2: "iRullo es la app definitiva que te mostrará las notivias de última hora sobre tu deporte favorito"
        case .page3: "iRullo te muestra los eventos deportivos sobre tu gran afición y sin pagar nada y sin publicidad"
        case .page4: "Pues iRullo te cuenta que pasa en el último momento y con una gran cantidad de información, adelante a disfrutar de iRullo"
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
