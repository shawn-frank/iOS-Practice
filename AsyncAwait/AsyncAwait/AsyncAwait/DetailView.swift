//
//  DetailView.swift
//  AsyncAwait
//
//  Created by Shawn Frank on 23/2/2023.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        Text(user.name)
        Text("\(user.age)")
        List(user.subjects) { subject in
            Text(subject.name)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DetailView(user: User(id: 1,
                                  name: "Shawn",
                                  age: 15,
                                  subjects: []))
        }
    }
}
