//
//  ViewModel.swift
//  AsyncAwait
//
//  Created by Shawn Frank on 23/2/2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var networkError: NetworkError = .none
    
    @MainActor
    func fetchData() async {
        guard let url = URL(string: "https://api.npoint.io/94152b6ca15ea3223a4d") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            self.users = try decoder.decode([User].self, from: data)
        }
        catch {
            
            DispatchQueue.main.async {
                print(error.localizedDescription)
                self.networkError = .decodeError
            }
            return
        }
    }
    
    func removeAll() {
        users = []
    }
}

enum NetworkError: String, Error {
    case requestError = "Unable to make a request, try again later"
    case decodeError = "Invalid data received"
    case none
}
