//
//  Movie.swift
//  MovieList
//
//  Created by Daniel Stahl on 12/26/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import Foundation

struct Movie {
    var title: String
    var description: String?
    var actors: [String]?
    var year: Int?
    var length: Int?
    
    static func loadMovies() -> [Movie]? {
        return nil
    }
    
    static func loadSampleMovies() -> [Movie] {
        let movie1 = Movie(title: "First Blood", description: "Former Green Beret John Rambo is pursued into the mountains surrounding a small town by a tyrannical sheriff and his deputies, forcing him to survive using his combat skills.", actors: ["Sylvester Stallone", "Brian Dennehy"], year: 1982, length: 109)
        
        let movie2 = Movie(title: "The Ring", description: "A journalist must investigate a mysterious videotape which seems to cause the death of anyone one week to the day after they view it.", actors: ["Naomi Watts", "Martin Henderson", "Brian Cox"], year: 2002, length: 115)
        
        return [movie1, movie2]
    }
    
    
    
}
