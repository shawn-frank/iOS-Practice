//
//  Budget.swift
//  BudgetTrackPractice
//
//  Created by Shawn Frank on 20/2/2023.
//

import Foundation

struct Budget {
    var weeklyRemaining: Decimal
    var dailyRemaining: Decimal
    
    init(with start: Decimal) {
        weeklyRemaining = start
        dailyRemaining = start / 7
    }
    
    mutating func addTransaction(amount: Decimal, on date: Date) {
        weeklyRemaining -= amount
        dailyRemaining -= amount
    }
}
