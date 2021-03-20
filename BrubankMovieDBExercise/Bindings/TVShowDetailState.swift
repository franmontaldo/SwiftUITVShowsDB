//
//  TVShowDetailState.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

class TVShowDetailState: ObservableObject {
    
    private let TVShowService: APIRequestProtocol
    @Published var tvShow: TVShow?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(TVShowRequestProtocol: APIRequestProtocol = APIRequest.shared) {
        self.TVShowService = TVShowRequestProtocol
    }
    
    func loadTVShow(id: Int) {
        self.tvShow = nil
        self.isLoading = false
        self.TVShowService.fetchTVShow(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let TVShow):
                self.tvShow = TVShow
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}

