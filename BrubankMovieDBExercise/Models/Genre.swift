//
//  Genres.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 18/03/2021.
//

import Foundation

struct GenreListResponse: Decodable {
    let genres: [Genre]
}

// MARK: - GenreElement
struct Genre: Codable, Identifiable, Hashable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    let id: Int?
    let name: String?
}
