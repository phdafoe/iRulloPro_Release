//
//  MainHeaderView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct MainHeaderView: View {
    
    @State private var showProfileView: Bool = true
    
    var body: some View {
        VStack {
            
            HStack{
                Text("iRullo")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
                Button(action: {
                    showProfileView.toggle()
                }) {
                    Image(systemName: "person.circle")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Futbol")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Baloncesto")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Motor")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                    
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Tenis")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Ciclismo")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                    Button(action: {
                        showProfileView.toggle()
                    }) {
                        Text("Más deporte")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(3)
                            .padding(.horizontal)
                    }
                    .border(Color.white)
                    
                }
                .frame(height: 50)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            }
            .padding(.horizontal)
            
        }
        .background(.red)
        .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

#Preview {
    MainHeaderView()
}
