//
//  TVShowSearchView.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

struct TVShowSearchView: View {
    
    @ObservedObject var tvShowSearchState = TVShowSearchState()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeholder: "Search TV Show", text: self.$tvShowSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.tvShowSearchState.isLoading, error: self.tvShowSearchState.error) {
                    self.tvShowSearchState.search(query: self.tvShowSearchState.query)
                }
                
                if self.tvShowSearchState.tvShows != nil {
                    ForEach(self.tvShowSearchState.tvShows!) { tvShow in
                        NavigationLink(destination: TVShowDetailView(tvShowId: tvShow.id)) {
                            VStack(alignment: .leading) {
                                Text(tvShow.name)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                self.tvShowSearchState.startObserve()
            }
            .navigationBarTitle("Search")
        }
    }
}

struct TVShowSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowSearchView()
    }
}
