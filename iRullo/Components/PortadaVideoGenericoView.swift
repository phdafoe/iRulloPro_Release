//
//  PortadaVideoGnericoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct PortadaVideoGenericoView: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
    private var modelData: ContentVideosModel
    private var kickerPortada: String?
    private var titlePortada: String?
    private var subtitlePortada: String?

    
    init(model: ContentVideosModel) {
        self.modelData = model
        
        self.kickerPortada = model.headlines?.kickerPortada
        self.titlePortada = model.headlines?.titlePortada
        self.subtitlePortada = model.headlines?.subtitlePortada
        
        model.contentData?.forEach { data in
            data.elementosModel?.forEach { data in
                if let aux = data.videoModel?.stillsVersions?.last {
                    self.imageLoaderVM.loadImage(whit: aux.uriPathURL)
                }
                
            }
        }
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } else {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .cornerRadius(8)
                }
            }
            .frame(width: 306, height: 150)
            
            VStack(alignment: .leading){
                Text(self.kickerPortada ?? "")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .bold()
                Text(self.titlePortada ?? "")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                Text(self.subtitlePortada ?? "")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.white)
                    .padding([.top,.bottom], 5)
            }
        }
    }
}

