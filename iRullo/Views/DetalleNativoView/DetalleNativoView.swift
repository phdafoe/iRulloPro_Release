//
//  DetalleNativoView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/8/24.
//

import SwiftUI

struct DetalleNativoView: View {
    
    private let imageLoader = ImageLoader()
    var data: NoticiasData?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            VStack{
                headerView()
                
                VStack(alignment: .leading, spacing: 30){
                    HStack{
                        Text(data?.typenameNoticia ?? "iRullo")
                        Text("·")
                        Text(data?.subtitleNoticia?.uppercased() ?? "")
                            .bold()
                    }
                    
                    Text(data?.titleNoticia ?? "")
                        .font(.title2)
                    
                
                    
                    Text(data?.leadingNoticia ?? "")
                        .font(.title2)
                    
                    Text(data?.cleanedText ?? "")
                        .font(.title2)
                    
//                    HStack{
//                        if !(self.viewModel.model?.ratingText.isEmpty ?? false) {
//                            Text(self.viewModel.model?.ratingText ?? "")
//                                .foregroundColor(.red)
//                        }
//                        Text(self.viewModel.model?.scoreText ?? "")
//                        Spacer()
//                    }
                    
//                    Text("Starring")
//                        .font(.title)
//                        .fontWeight(.bold)
//                    ScrollView(.horizontal, showsIndicators: true) {
//                        if self.viewModel.model?.cast != nil && !(self.viewModel.model?.cast?.isEmpty ?? false) {
//                            MovieCastCrrousel(model: self.viewModel.model?.cast ?? [])
//                        }
//                    }
//                    .padding(.bottom, self.viewModel.arrayShowsRecommendation.isEmpty ? 100 : 0)
                    
//                    HStack(alignment: .top, spacing: 4) {
//                        if self.viewModel.model?.crew != nil && !(self.viewModel.model?.crew?.isEmpty ?? false) {
//                            VStack(alignment: .leading, spacing: 4) {
//                                if self.viewModel.model?.directors != nil && !(self.viewModel.model?.directors?.isEmpty ?? false ) {
//                                    Text("Directors")
//                                        .font(.title)
//                                        .fontWeight(.bold)
//                                        .padding(.top)
//                                    ForEach((self.viewModel.model?.directors!.prefix(2))!) { item in
//                                        Text(item.name ?? "")
//                                    }
//                                }
//                                if self.viewModel.model?.producers != nil && !(self.viewModel.model?.producers?.isEmpty ?? false ) {
//                                    Text("Producer[s]")
//                                        .font(.title)
//                                        .fontWeight(.bold)
//                                        .padding(.top)
//                                    ForEach((self.viewModel.model?.producers!.prefix(2))!) { item in
//                                        Text(item.name ?? "")
//                                    }
//                                }
//                                if self.viewModel.model?.screenWriters != nil && !(self.viewModel.model?.screenWriters?.isEmpty ?? false ) {
//                                    Text("Writer[s]")
//                                        .font(.title)
//                                        .fontWeight(.bold)
//                                        .padding(.top)
//                                    ForEach((self.viewModel.model?.screenWriters!.prefix(2))!) { item in
//                                        Text(item.name ?? "")
//                                    }
//                                }
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                    }
                    
                    
//                    if self.viewModel.model?.youtubeTrailers != nil && !(self.viewModel.model?.youtubeTrailers?.isEmpty ?? false) {
//                        VStack(alignment: .leading, spacing: 20){
//                            Text("Trailers")
//                                .font(.title)
//                                .fontWeight(.bold)
//                            ForEach((self.viewModel.model?.youtubeTrailers)!) { item in
//                                Button {
//                                    self.selectedTrailer = item
//                                } label: {
//                                    HStack{
//                                        Text(item.name ?? "")
//                                        Spacer()
//                                        Image(systemName: "play.circle.fill")
//                                            .foregroundColor(Color.red)
//                                    }
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        .padding(.bottom, self.viewModel.arrayShowsRecommendation.isEmpty ? 100 : 0)
//                        
//                    }
                    
//                    Group{
//                        if !self.viewModel.arrayShowsRecommendation.isEmpty {
//                            ShowsPosterCarrouselView(title: "Recommended for you",
//                                                     isPosterFromShowsView: true,
//                                                     showsModel: self.viewModel.arrayShowsRecommendation)
//                        }
//                    }
//                    .padding(.bottom, 100)
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
    }
    
    
    func headerView() -> some View {
        ZStack(alignment: .topLeading) {
            if self.data?.shotsNoticia?.urlPathURL != nil {
                NewDetailImage(imageURL: self.data?.shotsNoticia?.urlPathURL,
                               imageLoderVM: imageLoader)
                .listRowInsets(EdgeInsets(top: 0,
                                          leading: 20,
                                          bottom: 0,
                                          trailing: 20))
            }
            
//            HStack{
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                }
//                .padding()
//                .background(Color.white.opacity(0.7))
//                .clipShape(Circle())
//                .padding(EdgeInsets(top: 40,
//                                    leading: 20,
//                                    bottom: 0,
//                                    trailing: 0))
//                
//            }
//            .foregroundColor(.red)
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
