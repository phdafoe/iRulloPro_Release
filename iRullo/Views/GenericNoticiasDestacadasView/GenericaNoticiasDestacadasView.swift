//
//  GenericaNoticiasDestacadasView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/9/24.
//

import SwiftUI

struct GenericaNoticiasDestacadasView: View {
    
    @StateObject var viewModel = GenericaNoticiasDestacadasPresenter()
    @State var name : String
    
    fileprivate func portadaGenericoView() -> some View {
        return VStack {
            HStack {
                Text("Destacados \(self.name)")
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
        }
    }
    
    var body: some View {
        ZStack {
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    portadaGenericoView()
                }
                .refreshable {
                    self.viewModel.fetchDataPortadaGenericas(name: self.name)
                }
            }
            .onAppear{
                self.viewModel.fetchDataPortadaGenericas(name: self.name)
            }
        }
    }
}

#Preview {
    GenericaNoticiasDestacadasView(name: "")
}
