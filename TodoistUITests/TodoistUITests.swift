//
//  TodoistUITests.swift
//  TodoistUITests
//
//  Created by Frederico Kuckelhaus on 23.02.22.
//

import XCTest
@testable import Todoist

class TodoistUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AppHas4Tabs() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs in the app.")
    }

    func test_OpenTabAddsItems() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")

        for tapCount in 1...5 {
            app.buttons["Add Project"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) rows")
        }
    }

    func test_addingItemInsertsRows() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")

        app.buttons["Add Project"].tap()
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding Project")

        app.buttons["Add new item"].tap()
        XCTAssertEqual(app.tables.cells.count, 2, "There should be 2 list row after adding Project and 1 Item")
    }

    // TODO: - test is failing on tapping textfield
//    func test_EditingProjectUpdatesCorrectly() {
//        app.buttons["Open"].tap()
//        XCTAssertEqual(app.tables.cells.count, 0, "There should be no list rows initially")
//
//        app.buttons["Add Project"].tap()
//        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 list row after adding Project")
//
//        app.buttons["Add Project"].tap()
//        app.images
//        app.textFields["New Project"].tap()
//
//        app.keys["space"].tap()
//        app.keys["more"].tap()
//        app.keys["2"].tap()
//        app.buttons["Return"].tap()
//
//        app.buttons["Open Projects"].tap()
//        XCTAssertTrue(app.buttons["New Project 2"].exists)
//    }

    func test_allAwardsShowLockedAlert() {
        app.buttons["Awards"].tap()

        for award in app.scrollViews.allElementsBoundByIndex {
            award.tap()

            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a locked award alert")
            app.buttons["OK"].tap()
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
