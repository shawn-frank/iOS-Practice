//
//  CircleImage.swift
//  Basic Views Practice
//
//  Created by Shawn Frank on 24/3/2023.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("cat")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
