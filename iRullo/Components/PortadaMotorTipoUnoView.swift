//
//  PortadaMotorTipoUnoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 8/8/24.
//

import SwiftUI

struct PortadaMotorTipoUnoView: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    private var contentData: PortadaMotorModel?
    
    private var kickerPortada: String?
    private var titlePortada: String?
    private var subtitlePortada: String?
    
    var urlwebView: URL?
    
    init(contentData: PortadaMotorModel?, urlwebView: URL? = nil) {
        
        self.contentData = contentData
        
        contentData?.groups?.forEach{ data in
                        
            data.contents?.forEach { data in
                
                self.kickerPortada = data.headlines?.kickerPortada
                self.titlePortada = data.headlines?.titlePortada
                self.subtitlePortada = data.headlines?.subtitlePortada
                
                self.urlwebView = data.resourceURL?.uriPathURL
                
                data.elementosModel?.forEach{ data in
                    if let aux = data.photo?.versions?.first {
                        if data.photo?.versions != nil{
                            self.imageLoaderVM.loadImage(whit: aux.uriPathURL)
                        }
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        if self.urlwebView != nil {
            NavigationLink(destination: WebView(url: self.urlwebView!)) {
                VStack(alignment: .leading){
                    if self.imageLoaderVM.image != nil {
                        Image(uiImage: self.imageLoaderVM.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .loader(state: .ok)
                        
                    } else {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]),
                                                 startPoint: .bottom,
                                                 endPoint: .top))
                            .cornerRadius(8)
                            .loader(state: .loading)
                    }
                    HStack(alignment: .top){
                        
                        Rectangle()
                            .frame(width: 5, height: 50)
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading){
                            
                            Text(self.kickerPortada ?? "iRULLO")
                                .foregroundStyle(.white)
                                .bold()
                            
                            Text(self.titlePortada ?? "")
                                .font(.title3)
                                .foregroundStyle(.white)
                            
                            Text(self.titlePortada ?? "")
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

