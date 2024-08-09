//
//  PortadaModorView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import SwiftUI

struct PortadaMotorView: View {
    
    @StateObject var viewModel = PortadaMotorPresenter()
    @State var showProfileView = false
    
    
    fileprivate func portadaView() -> some View {
        return VStack {
            ForEach(viewModel.portadasMotor ?? []) { index in
                PortadaMotorTipoUnoView(contentData: index)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                MainHeaderView(showProfileView: $showProfileView, tituloVista: "Motor")
                ScrollView(.vertical, showsIndicators: false){
                    portadaView()
                }
                .refreshable {
                    await self.viewModel.fetchData()
                }
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
    PortadaMotorView()
}
