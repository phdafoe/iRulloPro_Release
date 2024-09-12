//
//  CustomAlertView.swift
//  FashionApp
//
//  Created by TECDATA ENGINEERING on 21/2/22.
//

import SwiftUI

struct CustomAlertView: View {
    
    var title: String
    var message: String
    var imageURL: URL? = nil
    var hideCustomAlertView: (Bool) -> Void
    var hideAlertV: Binding<Bool>
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    init(title: String,
         message: String,
         imageURL: URL? = nil,
         hideAlert: Binding<Bool>,
         hide: @escaping (Bool) -> Void) {
        self.title = title
        self.message = message
        self.imageURL = imageURL
        self.hideCustomAlertView = hide
        self.hideAlertV = hideAlert
        guard let imageURLUnw = self.imageURL else {return}
        self.imageLoaderVM.loadImage(whit: imageURLUnw)
    }
    
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                HStack{
                    Spacer()
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        // Aqui va la accion del Binding
                        self.hideAlertV.wrappedValue = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    }
                }
                Divider()
                if title == "Estas seguro?" {
                    Text(message)
                        .font(.title3)
                } else {
                    ScrollView{
                        Text(message)
                            .font(.title3)
                    }
                }
                
                
                Button {
                    self.hideCustomAlertView(true)
                    self.hideAlertV.wrappedValue = false
                } label: {
                    Text("OK")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }

                
                if self.imageLoaderVM.image != nil{
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .shadow(radius: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 1)
                        )
                        .loader(state: .ok)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.90)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(10)
            .shadow(radius: 10)
   
        }
    }
}


