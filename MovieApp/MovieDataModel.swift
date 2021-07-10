//
//  MovieDataModel.swift
//  MovieApp
//
//  Created by Bhupender Rawat on 25/06/21.
//

import Foundation

struct Movie: Codable {
    let original_title: String
    let overview: String
    let poster_path: String
}

struct SampleMovie: Codable {
    let movies: [Movie]
}
