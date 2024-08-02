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
        }
        .background(.red)
    }
}

#Preview {
    MainHeaderView()
}
