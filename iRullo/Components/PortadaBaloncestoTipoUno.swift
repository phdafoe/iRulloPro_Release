//
//  PortadaBaloncestoTipoUno.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import SwiftUI

struct PortadaBaloncestoTipoUno: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    
    let contentData: PortadaBaloncestoModel?
    
    private var kickerPortada: String?
    private var titlePortada: String?
    private var subtitlePortada: String?
   
    var urlwebView: URL?

    init(contentData: PortadaBaloncestoModel?, urlwebView: URL? = nil) {
        
        self.contentData = contentData

        contentData?.groups?.forEach{ data in
                        
            data.contents?.forEach { data in
                
                self.kickerPortada = data.headlines?.kickerPortada
                self.titlePortada = data.headlines?.titlePortada
                self.subtitlePortada = data.headlines?.subtitlePortada
                
                self.urlwebView = data.resourceURL?.uriPathURL
                
                data.elementosModel?.forEach{ data in
                    if let aux = data.photo?.versions?.last {
                        if data.photo?.versions != nil{
                            self.imageLoader.loadImage(whit: aux.uriPathURL)
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
                    HStack(alignment: .top) {
                        if self.imageLoader.image != nil {
                            VStack{
                                Image(uiImage: self.imageLoader.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .loader(state: .ok)
                            }
                        } else {
                            ZStack{
                                Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]),
                                                         startPoint: .bottom,
                                                         endPoint: .top))
                                    .cornerRadius(8)
                                    .loader(state: .loading)
                            }
                            
                        }
                        
                        VStack(alignment: .leading){
                            Text(self.kickerPortada ?? "iRULLO")
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .bold()
                            
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 5)
                            
                            Text(self.titlePortada ?? "Actualmente tenemos algún problema con esta noticia, disculpa las molestias!!")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                                .lineLimit(3)
                            
                            Text(self.subtitlePortada ?? "")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding([.top,.bottom], 5)
                                .lineLimit(3)
                        }
                        
                        
                    }
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(.red)
                        .padding(.horizontal, 5)
                }
                .background(.black)
            }
            .buttonStyle(PlainButtonStyle())
        }
        
    }
}

