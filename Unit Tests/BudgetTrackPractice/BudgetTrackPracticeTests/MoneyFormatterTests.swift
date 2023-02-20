//
//  MoneyFormatterTests.swift
//  BudgetTrackPracticeTests
//
//  Created by Shawn Frank on 20/2/2023.
//

import XCTest
@testable import BudgetTrackPractice

class MoneyFormatterTests: XCTestCase {

    let formatter = MoneyFormatter()
    
    func testMoneyFormatterWholeNumber() {
        XCTAssertEqual(formatter.string(Decimal(string: "0")!), "0.00")
        XCTAssertEqual(formatter.string(Decimal(string: "1")!), "1.00")
        XCTAssertEqual(formatter.string(Decimal(string: "5")!), "5.00")
        XCTAssertEqual(formatter.string(Decimal(string: "123")!), "123.00")
        XCTAssertEqual(formatter.string(Decimal(string: "-9")!), "-9.00")
    }
    
    func testMoneyFormatterDecimalWithOneDecimalPlace() {
        XCTAssertEqual(formatter.string(Decimal(string: "1.1")!), "1.10")
        XCTAssertEqual(formatter.string(Decimal(string: "1.2")!), "1.20")
        XCTAssertEqual(formatter.string(Decimal(string: "-1.1")!), "-1.10")
    }
    
    func testMoneyFormatterDecimalWithTwoDecimalPlace() {
        XCTAssertEqual(formatter.string(Decimal(string: "1.11")!), "1.11")
        XCTAssertEqual(formatter.string(Decimal(string: "1.25")!), "1.25")
        XCTAssertEqual(formatter.string(Decimal(string: "-1.13")!), "-1.13")
    }
    
    func testMoneyFormatterDecimalWithAnyDecimalPlaces() {
        XCTAssertEqual(formatter.string(Decimal(string: "1.112")!), "1.11")
        XCTAssertEqual(formatter.string(Decimal(string: "1.119")!), "1.11")
        XCTAssertEqual(formatter.string(Decimal(string: "1.23456789")!), "1.23")
        XCTAssertEqual(formatter.string(Decimal(string: "-1.23456789")!), "-1.24")
    }
}
