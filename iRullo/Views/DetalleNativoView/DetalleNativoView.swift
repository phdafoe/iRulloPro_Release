//
//  DetalleNativoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/8/24.
//

import SwiftUI

struct DetalleNativoView: View {
    
    @StateObject var viewModel = DetalleNativoPresenter()
    private let imageLoader = ImageLoader()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            VStack{
                headerView()
                
                VStack(alignment: .leading, spacing: 30){
                    HStack{
                        Text(self.viewModel.noticiasData?.typenameNoticia ?? "iRullo")
                        Text("·")
                        Text(self.viewModel.noticiasData?.subtitleNoticia?.uppercased() ?? "")
                            .bold()
                    }
                    
                    Text(self.viewModel.noticiasData?.titleNoticia ?? "")
                        .font(.title2)
                    
                
                    
                    Text(self.viewModel.noticiasData?.leadingNoticia ?? "")
                        .font(.title2)
                    
                    Text(self.viewModel.noticiasData?.cleanedText ?? "")
                        .font(.title2)
                }
                .multilineTextAlignment(.leading)
                .padding([.horizontal, .top], 20)
                .background(
                    roundedShape()
                        .fill(Color.black)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -50)
                )
                .padding(.top, -50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    func headerView() -> some View {
        ZStack(alignment: .topLeading) {
            if self.self.viewModel.noticiasData?.shotsNoticia?.urlPathURL != nil {
                NewDetailImage(imageURL: self.self.viewModel.noticiasData?.shotsNoticia?.urlPathURL,
                               imageLoderVM: imageLoader)
                .listRowInsets(EdgeInsets(top: 0,
                                          leading: 20,
                                          bottom: 0,
                                          trailing: 20))
            }
            
            HStack{
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 20,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 0))
                Spacer()
                
                Button(action: {
                    if self.viewModel.isFavoriteSelected ?? false {
                        self.viewModel.deletefavorito()
                    } else {
                        self.viewModel.saveDataInDDBB()
                    }
                    
                }) {
                    Image(systemName: self.viewModel.isFavoriteSelected ?? false ? "bookmark.fill" : "bookmark")
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 20,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 20))
                
            }
            .onAppear(perform: {
                self.viewModel.isFavorito()
            })
            .foregroundColor(.red)
        }
    }
}

struct NewDetailImage: View {
    
    let imageURL: URL?
    @ObservedObject var imageLoderVM: ImageLoader
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .shadow(radius: 10)
                .loader(state: .loading)
            if self.imageLoderVM.image != nil {
                Image(uiImage: self.imageLoderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .loader(state: .ok)
            }
        }
        .onAppear {
            self.imageLoderVM.loadImage(whit: imageURL!)
        }
    }
}

struct roundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

#Preview {
    DetalleNativoView()
}
