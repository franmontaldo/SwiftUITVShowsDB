//
//  FavoriteTVShowCarouselView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

struct FavoriteTVShowCarouselView: View {
    
    let title: String = "SUSCRIPTAS"
    let tvShows: [TVShow]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.tvShows) { tvShow in
                        NavigationLink(destination: TVShowDetailView(tvShowId: tvShow.id)) {
                            TVShowPosterView(tvShow: tvShow)
                        }
                        .frame(width: 100 , height: 150)
                        //                            .buttonStyle(PlainButtonStyle())
                        .padding(.leading, tvShow.id == self.tvShows.first!.id ? 16 : 0)
                        .padding(.trailing, tvShow.id == self.tvShows.last!.id ? 16 : 0)
                    }
                }
            }
            
        }
        
        
    }
}

struct FavoriteTVShowCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteTVShowCarouselView(tvShows: TVShow.exampleTVShows).preferredColorScheme(.dark)
    }
}
