//
//  NetworkService.swift
//  CombinePractice
//
//  Created by Shawn Frank on 19/2/2023.
//

import Foundation

struct NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func verifyUserName(_ username: String, completion: @escaping (Bool) -> ()) {
        
        print("Verify username \(username)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if username == "sss" {
                print("\(username) exists")
            }
            else {
                print("\(username) doesn't exist")
            }
            
            completion(username != "sss")
        }
        
        
    }
}
