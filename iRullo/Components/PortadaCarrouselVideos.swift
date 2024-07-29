//
//  PortadaCarrouselVideos.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 29/7/24.
//

import SwiftUI

struct PortadaCarrouselVideos: View {
    
    var title: String
    var isPosterFromMoviesView: Bool
//    var moviesModel: [MoviesShowsModel]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Rectangle()
                    .fill(Color(UIColor.cyan).opacity(0.3))
                    .frame(width: 50, height: 5)
            }.padding(.bottom, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
//                    ForEach(self.moviesModel) { movie in
////                        if movie.mediaType == "movie"{
////                            NavigationLink(destination: DetailMovieCoordinator.view(dto: DetailMovieCoordinatorDTO(movieObject: movie))) {
////                                MoviePosterCell(model: movie,
////                                                isPoster: self.isPosterFromMoviesView)
////                            }
////                            .buttonStyle(PlainButtonStyle())
////                        }
//                    }
                }
            }
        }
    }
}

