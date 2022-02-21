//
//  AssetTest.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 16.02.22.
//

import XCTest
@testable import Todoist

class AssetTest: XCTestCase {

    func testColorsExist() {
        for color in Project.colours {
            XCTAssertNotNil(UIColor(named: color), "Failed to load '\(color)' from asset")
        }
    }

    func testJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON")
    }
}
