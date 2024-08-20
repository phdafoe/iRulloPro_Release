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
    @Binding var isFullScreen: Bool?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    
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
                if isFullScreen ?? false{
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.light)
                    }
                } else {
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Image(systemName: "person.circle")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.light)
                    }
                    .sheet(isPresented: $showProfileView) {
                        PerfilView(tipoAutentication: .signup)
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
        }
        .background(.red)
    }
}

