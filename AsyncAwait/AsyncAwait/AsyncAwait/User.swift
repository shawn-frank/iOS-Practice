//
//  UserModel.swift
//  AsyncAwait
//
//  Created by Shawn Frank on 23/2/2023.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int64
    let name: String
    let age: Int64
    let subjects: [Subject]
}

struct Subject: Codable, Identifiable {
    let id: Int64
    let name: String
    let credit: Int
}
