//
//  BudgetTests.swift
//  BudgetTrackPracticeTests
//
//  Created by Shawn Frank on 20/2/2023.
//

import XCTest
@testable import BudgetTrackPractice

class BudgetTests: XCTestCase {

    func testBudgetContainsWeeklyRemaining() {
        let numbers: [Decimal] = [0, 1, 10, 100]
        
        for number in numbers {
            let budget = Budget(with: number)
            XCTAssertEqual(budget.weeklyRemaining, number)
        }
    }
    
    func testBudgetContainsDailyRemaining() {
        let numbers: [Decimal] = [0, 7, 700, 49]
        
        for number in numbers {
            let budget = Budget(with: number)
            XCTAssertEqual(budget.dailyRemaining, number / 7, "daily remaining is not \(number/7)")
        }
    }
    
    func testTransactionDeductsFromWeeklyRemaining() {
        var budget = Budget(with: 10)
        budget.addTransaction(amount: 0, on: Date())
        XCTAssertEqual(budget.weeklyRemaining, 10)
        
        budget.addTransaction(amount: 2, on: Date())
        XCTAssertEqual(budget.weeklyRemaining, 8)
        
        budget.addTransaction(amount: 5, on: Date())
        XCTAssertEqual(budget.weeklyRemaining, 3)
    }

    func testTransactionDeductsFromDailyRemaining() {
        var budget = Budget(with: 70)
        budget.addTransaction(amount: 0, on: Date())
        XCTAssertEqual(budget.dailyRemaining, 10)
        
        budget.addTransaction(amount: 1, on: Date())
        XCTAssertEqual(budget.dailyRemaining, 9)
        
        budget.addTransaction(amount: 4, on: Date())
        XCTAssertEqual(budget.dailyRemaining, 5)
    }
}
