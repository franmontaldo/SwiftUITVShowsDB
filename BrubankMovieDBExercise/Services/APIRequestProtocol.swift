//
//  TVShowRequestProtocol.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import Foundation

protocol APIRequestProtocol {
    
    func fetchGenreList(completion: @escaping (Result<GenreListResponse, APIError>) -> ())
    func fetchTVShows(page: Int, completion: @escaping (Result<TVShowResponse, APIError>) -> ()) 
    func fetchTVShow(id: Int, completion: @escaping (Result<TVShow, APIError>) -> ())
    func searchTVShow(query: String, completion: @escaping (Result<TVShowResponse, APIError>) -> ())
}

enum APIError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}

