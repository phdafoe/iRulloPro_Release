//
//  PortadaNoticiasTipoDosView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/8/24.
//

import Foundation
import SwiftUI

struct PortadaNoticiasTipoDosView: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    let contentData: NoticiasData?
    
    init(contentData: NoticiasData?, urlwebView: URL? = nil) {
        self.contentData = contentData
        
        if let aux = self.contentData?.shotsNoticia {
            self.imageLoader.loadImage(whit: aux.urlPathURL)
        }
    }
    
    
    var body: some View {
        NavigationLink(destination: DetalleNativoView(data: self.contentData)) {
            VStack(alignment: .leading){
                if self.imageLoader.image != nil {
                    VStack{
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .loader(state: .ok)
                    }
                } else {
                    ZStack{
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]),
                                                 startPoint: .bottom,
                                                 endPoint: .top))
                            .cornerRadius(8)
                            .loader(state: .loading)
                    }
                }
                    
                
                Text(self.contentData?.titleNoticia?.uppercased() ?? "iRULLO")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .bold()
                    .lineLimit(2)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)
                
                Text(self.contentData?.subtitleNoticia ?? "Actualmente tenemos algún problema con esta noticia, disculpa las molestias!!")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .lineLimit(1)
                
                Text(self.contentData?.cleanedText ?? "Actualmente tenemos algún problema con esta noticia, disculpa las molestias!!")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding([.top,.bottom], 5)
                    .lineLimit(3)
                
            }
            .frame(width: 240, height: 306)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}
