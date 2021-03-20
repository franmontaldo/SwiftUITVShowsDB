//
//  TVShowPreview.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import Foundation

extension TVShow {
    
    static var exampleTVShows: [TVShow] {
        let response: TVShowResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "tvshow_list2")
        return response!.results
    }
    
    static var exampleTVShow: TVShow {
        exampleTVShows[0]
    }
    
}

extension Genre {
    
    static var exampleGenres: [Genre] {
        let response: GenreListResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "genres")
        return response!.genres
    }
    
    static var exampleGenre: Genre {
        exampleGenres[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        print(url)
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        do {
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
        } catch {
            print("ESTE ES EL ERROR: \n \(error)")
        }
        return nil
    }
}


