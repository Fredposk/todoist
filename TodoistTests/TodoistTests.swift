//
//  TodoistTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 16.02.22.
//

import XCTest
import CoreData
@testable import Todoist

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
