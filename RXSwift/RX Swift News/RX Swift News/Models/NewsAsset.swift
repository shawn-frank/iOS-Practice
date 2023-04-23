//
//  NewsAsset.swift
//  RX Swift News
//
//  Created by Shawn Frank on 23/4/2023.
//

import Foundation

struct NewsAsset: Decodable {
    let id: Int
    let url: String
    let headline: String
    let abstract: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case headline
        case abstract = "theAbstract"
    }
}
