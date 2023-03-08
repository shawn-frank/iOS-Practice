//
//  ContentView.swift
//  AsyncAwait
//
//  Created by Shawn Frank on 23/2/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        
        NavigationView {
            
            if vm.networkError != .none {
                Text("Network error").navigationTitle("Test")
            }
            else {
                List(vm.users) { user in
                    NavigationLink(user.name) {
                        DetailView(user: user)
                    }
                }
                .navigationBarItems(trailing: refreshButton)
                .navigationTitle("Test")
            }
        }
        .onAppear {
            Task {
                await vm.fetchData()
            }
        }
    }
    
    private var refreshButton: some View {
        Button {
            vm.removeAll()
            Task {
                await vm.fetchData()
            }
        } label: {
            Text("Refresh")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
