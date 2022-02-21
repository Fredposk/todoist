//
//  ExtensionTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 21.02.22.
//

import XCTest
@testable import Todoist

class ExtensionTests: XCTestCase {
    func test_SequenceSortingSelf() {
        let items = [1, 2, 4, 5, 3]
        let sortedItems = items.sorted(by: \.self)

        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "Items should be sorted")
    }

    func test_SequenceSortingComparable() {

        struct Example: Comparable {

            var value: String

            static func <(lhs: Example, rhs: Example) -> Bool {
                return lhs.value < rhs.value
            }
        }

        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")

        let examples = [example1, example3, example3]

        let sortedExamples = examples.sorted(by: \.self)

        XCTAssertEqual(sortedExamples, [example1, example2, example3], "Examples should be sorted")


    }


}
