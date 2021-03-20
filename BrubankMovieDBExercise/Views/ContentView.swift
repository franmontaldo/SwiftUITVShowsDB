//
//  ContentView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var tvShowListState = TVShowListState()
    @ObservedObject private var genreListState = GenreListState()
    
    var body: some View {
        NavigationView {
            ScrollView(){
                FavoriteTVShowCarouselView(tvShows: TVShow.exampleTVShows)
                if tvShowListState.tvShows == nil {
                    LoadingView(isLoading: self.tvShowListState.isLoading , error: self.tvShowListState.error) {
                        self.tvShowListState.loadTVShows()
                    }
                }
                else if genreListState.genres == nil {
                    LoadingView(isLoading: self.genreListState.isLoading , error: self.genreListState.error) {
                        self.genreListState.loadGenres()
                    }
                }
                else {
                    AllTVShowsView(tvShows: tvShowListState.tvShows!, genres: genreListState.genres!)
                }
            }
        }.navigationBarTitle("TV Show Reminder")
        .onAppear {
            self.tvShowListState.loadTVShows()
            self.genreListState.loadGenres()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
