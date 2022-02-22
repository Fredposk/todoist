//
//  ExtensionTests.swift
//  TodoistTests
//
//  Created by Frederico Kuckelhaus on 21.02.22.
//

import XCTest
@testable import Todoist
import SwiftUI

class ExtensionTests: XCTestCase {
    func test_SequenceSortingSelf() {
        let items = [1, 2, 4, 5, 3]
        let sortedItems = items.sorted(by: \.self)

        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "Items should be sorted")
    }

    func test_BundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array")
    }

    func test_DecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "Cause haters gonna hate",
                       "The test string must match the bundled string in decodableString.json")
    }

    func test_DecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String:Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, "Dictionary Contains 3 items")
    }

    func test_BindingOnChange() {
        var onChangeFunctionRun = false

        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }

        var storedValue = ""

        let binding = Binding {
            storedValue
        } set: {
            newValue in
            storedValue = newValue
        }

        let changedBinding = binding.onChange {
            exampleFunctionToCall()
        }

        changedBinding.wrappedValue = "Test"
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function is run when the binding is changed")
    }
}
