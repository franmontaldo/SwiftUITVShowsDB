//
//  GenreListState.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 18/03/2021.
//

import SwiftUI

class GenreListState: ObservableObject {
    
    @Published var genres: [Genre]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private let tvShowRequestProtocol: APIRequestProtocol
    
    init(tvShowRequestProtocol: APIRequestProtocol = APIRequest.shared) {
        self.tvShowRequestProtocol = tvShowRequestProtocol
    }
    func loadGenres() {
        self.genres = nil
        self.isLoading = true
        self.tvShowRequestProtocol.fetchGenreList() { [weak self] (result) in
            
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.genres = response.genres
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
