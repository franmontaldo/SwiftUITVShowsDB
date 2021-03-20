//
//  Constants.swift
//  BrubankMovieDBExercise
//
//  Created by Francisco Montaldo on 15/03/2021.
//

struct K {
    static let appName = "MovieDB"
    struct API {
        static let APIKey = "208ca80d1e219453796a7f9792d16776"
        static let baseTMDBURL = "https://www.themoviedb.org/"
        static let baseAPIURL = "https://api.themoviedb.org/3"
        static let baseAPIImageURL = "https://image.tmdb.org/t/p/w500"
        
        static let language = "en-US"
        static let region = "US"
        static let adultContent = "true"
        
        
        //MARK: - Api Authentication
        static let authURL = "https://api.themoviedb.org/3/authentication/token/new?api_key=" // returns a "request_token" in json
        static let tokenURL = "https://www.themoviedb.org/authenticate/{REQUEST_TOKEN}" // returns "session_id" to be logged with
        
        //MARK: - Api Requests
        
        
    }
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
}

