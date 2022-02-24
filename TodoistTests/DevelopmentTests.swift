//
//  DevelopmentTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 21.02.22.
//

import XCTest
import CoreData
@testable import Todoist

class DevelopmentTests: BaseTestCase {
    func test_SampleDataCreationWorks() throws {
        try dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5,
                       "There should be 5 sample Projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50,
                       "There should be 50 sample Items.")
    }

    func test_DeleteSampleData() throws {

         dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()),
                       0, "All created sample projects should be deleted")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0,
                       "All created sample items should be deleted")
    }

    func test_ExampleProjectIsClosed() {
        let project = Project.example
        XCTAssertTrue(project.closed, "Example Project should be closed")
    }

    func test_ExampleProjectItemIsHighPriority() {
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "Example item should be high priority")
    }
}
