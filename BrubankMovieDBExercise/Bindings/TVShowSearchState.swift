//
//  TVShowSearchState.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI
import Combine
import Foundation

class TVShowSearchState: ObservableObject {
    
    @Published var query = ""
    @Published var tvShows: [TVShow]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let tvShowRequestProtocol: APIRequestProtocol
    
    var isEmptyResults: Bool {
        !self.query.isEmpty && self.tvShows != nil && self.tvShows!.isEmpty
    }
    
    init(tvShowRequestProtocol: APIRequestProtocol = APIRequest.shared) {
        self.tvShowRequestProtocol = tvShowRequestProtocol
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.tvShows = nil
                self?.error = nil
                return text
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0) }
    }
    
    func search(query: String) {
        self.tvShows = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.tvShowRequestProtocol.searchTVShow(query: query) {[weak self] (result) in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvShows = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}
