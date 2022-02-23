//
//  PerformanceTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 22.02.22.
//

import XCTest
@testable import Todoist

class PerformanceTests: BaseTestCase {
    func test_AwardCalculationPerformance() throws {
        // Create a significant amount of data
        for _ in 1...100 {
            try dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500,
                       "This checks the number of awards is constant, change this if you add new awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
