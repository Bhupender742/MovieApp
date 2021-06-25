//
//  MovieDataModel.swift
//  MovieApp
//
//  Created by Bhupender Rawat on 25/06/21.
//

import Foundation

struct movie: Codable {
    let original_title: String
    let overview: String
    let poster_path: String    
}

struct movieList: Codable {
    let movies: [movie]
}
