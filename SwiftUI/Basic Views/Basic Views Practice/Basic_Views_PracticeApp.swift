//
//  Basic_Views_PracticeApp.swift
//  Basic Views Practice
//
//  Created by Shawn Frank on 24/3/2023.
//

import SwiftUI

@main
struct Basic_Views_PracticeApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
