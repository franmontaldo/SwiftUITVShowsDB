//
//  GenrePreview.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 18/03/2021.
//

import Foundation

extension Genre {
    
    static var exampleGenreList: [Genre] {
        let response: GenreListResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "genres")
        return response!.results
    }
    
    static var exampleGenre: Genre {
        exampleGenreList[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
