//
//  PortadaTipoDos.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import SwiftUI

struct PortadaTipoDos: View {
    
    let contentData: AreaPortadas?
    private var kickerPortada: String?
    private var titlePortada: String?
    private var subtitlePortada: String?
    
    @ObservedObject var imageLoader = ImageLoader()

    init(contentData: AreaPortadas?, urlwebView: URL? = nil) {
        self.contentData = contentData
        contentData?.groups?.forEach { data in
            data.contents?.forEach { data in
                data.elementosModel?.filter {
                    let isVideo = $0.elementType == "elementVideo"
                    let isPhoto = $0.elementType == "elementPhoto"
                    return isVideo || isPhoto
                }.forEach { data in
                    if let aux = data.videoModel?.stillsVersions?.last {
                        self.imageLoader.loadImage(whit: aux.uriPathURL)
                    }
                }
                self.kickerPortada = data.headlines?.kickerPortada
                self.titlePortada = data.headlines?.titlePortada
                self.subtitlePortada = data.headlines?.subtitlePortada
            }
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if self.imageLoader.image != nil {
                VStack{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            } else {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.clear]),
                                         startPoint: .bottom,
                                         endPoint: .top))
            }
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
        .background(.black)
    }
}

