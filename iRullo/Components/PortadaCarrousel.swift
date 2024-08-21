//
//  PortadaCarrousel.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct PortadaCarrousel: View {
    
    var title: String
    var isPosterFromMoviesView: Bool
    var noticias: [NoticiasData]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Rectangle()
                    .fill(Color(UIColor.cyan).opacity(0.3))
                    .frame(width: 50, height: 5)
            }.padding(.bottom, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(self.noticias) { noticia in
                        PortadaNoticiasTipoDosView(contentData: noticia,
                                                   urlwebView: noticia.urlPathURL)
                    }
                }
            }
        }
    }
}

