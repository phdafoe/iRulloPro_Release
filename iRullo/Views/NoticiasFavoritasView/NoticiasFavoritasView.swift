//
//  NoticiasFavoritasView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 11/9/24.
//

import SwiftUI

struct NoticiasFavoritasView: View {
    
    @StateObject var viewModel = NoticiasFavoritasPresenter()
    
    fileprivate func portadaFavoritasView() -> some View {
        return VStack {
            
            HStack {
                Text("Tus Favoritos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Rectangle()
                    .fill(Color(UIColor.cyan).opacity(0.3))
                    .frame(width: 50, height: 5)
                Spacer()
            }.padding(.bottom, 20)
            
            ForEach(viewModel.portadasGenerico ?? []) { index in
                PortadaGenericaTipoDosView(contentData: index)
            }
            
            if let isEmpty = viewModel.portadasGenerico?.isEmpty {
                if isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "timelapse")
                            .font(.largeTitle)
                            .scaledToFit()
                            .foregroundColor(.red)
                        Text("La lista de tus noticias favoritas está vacía, añade las noticias que quierás recordar o compartir")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .kerning(2)
                        
                    }
                    .padding(20)
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    portadaFavoritasView()
                }
                .refreshable {
                    self.viewModel.fetchDataPortadaGenericas()
                }
            }
            .onAppear{
                self.viewModel.fetchDataPortadaGenericas()
            }
        }
    }
}

#Preview {
    NoticiasFavoritasView()
}
