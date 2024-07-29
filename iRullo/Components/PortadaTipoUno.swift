//
//  PortadaTipoUno.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 19/7/24.
//

import SwiftUI

struct PortadaTipoUno: View {
    
    let contentData: AreaPortadas?
    var urlwebView: URL?
    @ObservedObject var imageLoader = ImageLoader()

    init(contentData: AreaPortadas?, urlwebView: URL? = nil) {
        self.contentData = contentData
        if let auxModel = contentData?.groups?.first?.contents?.first?.resourcePhotos {
            let dataModel = auxModel.filter { $0.titleControlMovil == "Frontis app móvil vertical"}
            for c_index in dataModel{
                self.imageLoader.loadImage(whit: c_index.imageName!.uriPathURL)
            }
        }
        
        if let auxModelUri = contentData?.groups?.first?.contents?.first?.resourceURL?.uriPathURL{
            self.urlwebView = auxModelUri
        }
    }
    
    var body: some View {
        VStack {
            if self.urlwebView != nil {
                NavigationLink(destination: WebView(url: self.urlwebView!)) {
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
                }
            }
        }
    }
}

