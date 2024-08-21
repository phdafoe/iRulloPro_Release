//
//  DetalleNativoDosView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 21/8/24.
//

import SwiftUI
import SwiftSoup

struct DetalleNativoDosView: View {
    
    private let imageLoader = ImageLoader()
    var data: String?
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ScrollView{
            Text(getTitle(htmlText: data ?? "AQUI ANDRES")).font(.title).bold()
                .padding(.bottom)
            Text(getParrafo(htmlText: data ?? "AQUI ANDRES")).font(.title3)
                .padding(.top)
        }
        .padding()
    }
    
    private func getTitle(htmlText: String) -> String {
        var aux = ""
        do {
            let document = try SwiftSoup.parse(htmlText)
            let cleanedHtml = try document.title()
            aux = cleanedHtml
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return aux
    }
    
    private func getParrafo(htmlText: String) -> String {
        var aux = ""
        do {
            
            let document = try SwiftSoup.parse(htmlText)
            try document.select("head").remove()
            try document.select("style").remove()
            try document.select("script").remove()
            try document.select("li").remove()
            try document.select("ul").remove()
            
            
            
            let cleanedHtml = try document.body()?.text() ?? "AQUI ANDRES"
            
            // Diccionario que define los caracteres a reemplazar y sus reemplazos
            let replacements: [String: String] = [
                "TITANIA COMPAÑÍA EDITORIAL, S.L.": "",
                "Es noticia cerrar Noticias Verticales Área de usuario Otros": "",
                "Todos los derechos reservados Condiciones Política de privacidad Transparencia Auditado por GFK Canal Interno de Información Menú Últimas noticias Mundo": "",
                "Última hora Ver más Noticias de Italia El redactor recomienda © TITANIA COMPAÑÍA EDITORIAL, S.L. 2024. España. Todos los derechos reservados Condiciones Política de Privacidad Política de Cookies Configuración de Cookies Auditado por GFK Datos de mercado proporcionados por TradingView Canal Interno de Información": "",
                "TE PUEDE INTERESAR": ""
            ]
            
            var modifiedText = cleanedHtml
            
            for (target, replacement) in replacements {
                modifiedText = modifiedText.replacingOccurrences(of: target, with: replacement)
            }
            
            aux = modifiedText.replacingOccurrences(of: ".", with: ".\n\n")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        return aux
    }
}

#Preview {
    DetalleNativoDosView()
}
