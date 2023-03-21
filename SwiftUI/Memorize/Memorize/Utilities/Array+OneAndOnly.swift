//
//  Array+OneAndOnly.swift
//  Memorize
//
//  Created by Shawn Frank on 21/3/2023.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count > 1 {
            return nil
        }
        
        return first
    }
}
