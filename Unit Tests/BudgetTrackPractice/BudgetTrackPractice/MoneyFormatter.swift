//
//  MoneyFormatter.swift
//  BudgetTrackPractice
//
//  Created by Shawn Frank on 20/2/2023.
//

import Foundation

struct MoneyFormatter {
    
    func string(_ decimal: Decimal) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.roundingMode = .floor
        let formattedAmount = numberFormatter.string(from: decimal as NSNumber)!
        return formattedAmount
    }
}
