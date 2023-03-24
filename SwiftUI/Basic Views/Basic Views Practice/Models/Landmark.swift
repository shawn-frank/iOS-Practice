//
//  Landmark.swift
//  Basic Views Practice
//
//  Created by Shawn Frank on 25/3/2023.
//

import Foundation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
}
