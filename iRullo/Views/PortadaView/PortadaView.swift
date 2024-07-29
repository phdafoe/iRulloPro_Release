//
//  PortadaView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/7/24.
//

import SwiftUI

struct PortadaView: View {
    
    @StateObject var viewModel = PortadaPresenter()
    @State private var showProfileView: Bool = true
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            PortadaTipoUno(contentData: viewModel.areasPortadas?.first)
            ForEach(viewModel.areasPortadas ?? []) { index in
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
    PortadaView()
}
