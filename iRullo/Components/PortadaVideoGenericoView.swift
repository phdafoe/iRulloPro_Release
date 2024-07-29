//
//  PortadaVideoGnericoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct PortadaVideoGenericoView: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
//    private var modelData: MoviesShowsModel

    
//    init(model: MoviesShowsModel, isPoster: Bool? = true) {
//        self.modelData = model
//        self.isPoster = isPoster ?? false
//        let y = Double(round(1000 * (self.modelData.voteAverage ?? 0.0) / 1000))
//        self.progressValue = y/10
//        if isPoster ?? false {
//            self.imageLoaderVM.loadImage(whit: model.posterUrl)
//        } else {
//            self.imageLoaderVM.loadImage(whit: model.backdropUrl)
//        }
//    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1)
                        )
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .cornerRadius(8)
                        .padding(-10)
                    
                    
                    VStack {
                        Spacer()
                            .frame(width: 30.0, height: 30.0)
                            .padding([.bottom, .trailing], 10.0)
                    }
                    
                } else {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .cornerRadius(8)
                }
            }
            .frame(width: 306, height: 150)
            
//            if !self.isPoster {
//                Text(self.modelData.name ?? "")
//                    .fontWeight(.semibold)
//                    .padding(.top, 15)
//                    .lineLimit(1)
//            }
        }
    }
}

#Preview {
    PortadaVideoGenericoView()
}
