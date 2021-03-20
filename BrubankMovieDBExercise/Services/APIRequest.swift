//
//  TVShowRequest.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import Foundation

class APIRequest : APIRequestProtocol {
    // Singleton
    static let shared = APIRequest()
    private init() {}
    
    private let apiKey = K.API.APIKey
    private let baseAPIURL = K.API.baseAPIURL
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchGenreList(completion: @escaping (Result<GenreListResponse, APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/genre/tv/list") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchTVShows(page: Int, completion: @escaping (Result<TVShowResponse, APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/popular") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "page": "\(page)"
        ], completion: completion)
    }
    
    func fetchTVShow(id: Int, completion: @escaping (Result<TVShow, APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func searchTVShow(query: String, completion: @escaping (Result<TVShowResponse, APIError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/tv") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "\(K.API.language)",
            "include_adult": "\(K.API.adultContent)",
            "region": "\(K.API.region)",
            "query": query
        ], completion: completion)
    }
    
    
    
    
    
    //MARK: - Helpers
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, APIError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            // Decoding:
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, APIError>, completion: @escaping (Result<D, APIError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
    
}
