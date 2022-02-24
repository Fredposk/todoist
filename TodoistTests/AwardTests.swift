//
//  AwardTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 17.02.22.
//

import XCTest
import CoreData
@testable import Todoist

class AwardTests: BaseTestCase {

    let awards = Award.allAwards

    func test_AwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }

    func test_NewUserAwardsShould_equalZero() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have not earned any awards")
        }
    }

    func test_AddingItems() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        for (count, value) in values.enumerated() {

            for _ in 0..<value {
                _ = Item(context: managedObjectContext)
            }
            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }
            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")
        }
    }

    func test_CompletedItems() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {

            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }

            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }
            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")
            dataController.deleteAll()
        }
    }
}
