//
//  PortadaVideoGnericoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct PortadaVideoGenericoView: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    private var modelData: ContentVideosModel?
    
    private var kickerPortada: String?
    private var titlePortada: String?
    private var subtitlePortada: String?
    
    var urlwebView: URL?

    
    init(model: ContentVideosModel?, urlwebView: URL? = nil) {
        self.modelData = model
        
        self.kickerPortada = model?.headlines?.kickerPortada
        self.titlePortada = model?.headlines?.titlePortada
        self.subtitlePortada = model?.headlines?.subtitlePortada
        
        self.urlwebView = model?.uriPathURL
        
        model?.contentData?.forEach { data in
            data.elementosModel?.forEach { data in
                if let aux = data.videoModel?.stillsVersions?.first {
                    self.imageLoaderVM.loadImage(whit: aux.uriPathURL)
                }
            }
        }
    }
    
    var body: some View {
        if self.urlwebView != nil {
            NavigationLink(destination: WebView(url: self.urlwebView!)) {
                VStack{
                    if self.imageLoaderVM.image != nil {
                        Image(uiImage: self.imageLoaderVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
//                            .loader(state: .ok)
                        
                    } else {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]),
                                                 startPoint: .bottom,
                                                 endPoint: .top))
                            .cornerRadius(8)
//                            .loader(state: .loading)
                    }
                    HStack(alignment: .top){
                        
                        Rectangle()
                            .frame(width: 5, height: 150)
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading){
                            
                            Text(self.kickerPortada ?? "iRULLO")
                                .foregroundStyle(.white)
                                .bold()
                            
                            Text(self.titlePortada ?? "")
                                .font(.title3)
                                .foregroundStyle(.white)
                            
                            Text(self.subtitlePortada ?? "")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(.red)
                        .padding(.horizontal, 5)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

