//
//  MainHeaderView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct MainHeaderView: View {
    
    @Binding var showProfileView: Bool
    var tituloVista: String
    
    var body: some View {
        VStack {
            HStack{
                Text("iRullo")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(self.tituloVista)
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button(action: {
                    showProfileView.toggle()
                }) {
                    Image(systemName: "person.circle")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.light)
                }
                .sheet(isPresented: $showProfileView) {
                    PortadaFutbolCoordinator.view()
                }
                
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
        }
        .background(.red)
    }
}

