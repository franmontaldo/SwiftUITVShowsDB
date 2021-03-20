//
//  FeedView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

struct AllTVShowsView: View {
    
    let allTitle: String = "TODAS"
    let subscriptionTitle: String = "SUSCRIPTAS"
    let tvShows: [TVShow]
    let genres: [Genre]
    
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("TODAS")
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(self.tvShows) { tvs in
                        if tvs.genreIds == nil {TVShowCard(tvShow: tvs, genre: nil)}
                        else {
                            ForEach(self.genres) {g in
                                if tvs.genreIds?[0] == g.id {
                                    TVShowCard(tvShow: tvs, genre: g)
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}

struct TVShowCard : View{
    let tvShow: TVShow
    let genre: Genre?
    @ObservedObject private var tvShowListState = TVShowListState()
    
    var body: some View {
        NavigationLink(destination: TVShowDetailView(tvShowId: tvShow.id)) {
            TVShowBackDropView(tvShow: tvShow, genre: genre)
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    // TODO: Hacer que la paginacion funcione!
                    self.tvShowListState.loadMoreTVShows(currentItem: tvShow)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        AllTVShowsView(tvShows: TVShow.exampleTVShows, genres: Genre.exampleGenres).preferredColorScheme(.dark)
    }
}
