//
//  PortadaFutbolView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 1/8/24.
//

import SwiftUI

struct PortadaFutbolView: View {
    
    @StateObject var viewModel = PortadaFutbolPresenter()
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasFutbol ?? []) { index in
                PortadaTipoDos(contentData: index)
            }
        }
    }
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                MainHeaderView()
                portadaView()
            }
            .onAppear{
                Task {
                    await self.viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    PortadaFutbolView()
}
