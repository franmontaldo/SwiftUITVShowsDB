//
//  TVShow.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

import Foundation

//MARK: - Response
struct TVShowResponse: Decodable {
    
    let results: [TVShow]
}


struct TVShow : Codable, Identifiable, Hashable{
    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //MARK: - Constants & Variables
    
    // Used
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let firstAirDate: String?
    let genreIds: [Int]?
    
    // Created ////////////////////////////////////////////////////////////////////////////////
    var isSuscribed: Bool  = false
    
    var backdropURL: URL {
        return URL(string: K.API.baseAPIImageURL + (backdropPath ?? ""))!
    }
    
    var posterURL: URL {
        return URL(string: K.API.baseAPIImageURL + (posterPath ?? ""))!
    }
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    

    
    // ////////////////////////////////////////////////////////////////////////////////////////
    
    enum CodingKeys: String, CodingKey {
        case backdropPath
        case firstAirDate
        case id
        case name
        case overview
        case posterPath
        case genreIds
    }
}



