//
//  TVShowListState.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 16/03/2021.
//

import SwiftUI

class TVShowListState: ObservableObject, RandomAccessCollection {
    subscript(position: Int) -> TVShow {
        return tvShows![position]
    }
    typealias Element = TVShow
    
    @Published var tvShows: [TVShow]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    var startIndex: Int { tvShows?.startIndex ?? 0 }
    var endIndex: Int { tvShows?.endIndex ?? 0}
    var loadStatus = LoadStatus.ready(nextPage: 1)
    var pageNumber: Int = 1
    
    
    private let tvShowRequestProtocol: APIRequestProtocol
    
    init(tvShowRequestProtocol: APIRequestProtocol = APIRequest.shared) {
        self.tvShowRequestProtocol = tvShowRequestProtocol
    }
    
    func loadTVShows() {
        self.tvShows = nil
        self.isLoading = true
        self.tvShowRequestProtocol.fetchTVShows(page: pageNumber) { [weak self] (result) in
            
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.tvShows = response.results
                self.pageNumber += 1
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    // TODO: Cada vez que entra a esta funcion el array .tvShows esta de vuelta en nil
    func loadMoreTVShows(currentItem: TVShow? = nil) {
        if self.tvShows == nil {
            return
        }
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        self.isLoading = true
        
        self.tvShowRequestProtocol.fetchTVShows(page: pageNumber) { [weak self] (result) in
            
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.tvShows! += response.results
                self.pageNumber += 1
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    
    func shouldLoadMoreData(currentItem: TVShow? = nil) -> Bool {
        if tvShows == nil {return true}
        guard let currentItem = currentItem else {
            return true
        }
        for n in (tvShows!.count - 4)...(tvShows!.count-1) {
            if n >= 0 && currentItem.id == tvShows![n].id {
                return true
            }
        }
        return false
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}
