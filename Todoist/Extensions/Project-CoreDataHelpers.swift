//
//  Project-CoreDataHelpers.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 24.01.22.
//

import Foundation
import SwiftUI

extension Project {

    static let colours = [
        "Pink",
        "Purple",
        "Red",
        "Orange",
        "Gold",
        "Green",
        "Teal",
        "Light Blue",
        "Dark Blue",
        "Midnight",
        "Dark Gray",
        "Gray"
    ]

    var projectTitle: String {
        title ?? NSLocalizedString("New Project", comment: "Create New Project")
    }

    var projectDetail: String {
        detail ?? ""
    }

    var projectColor: String {
        color ?? "Light Blue"
    }

    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }

    var projectItemsDefaultSorted: [Item] {
        return projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }

            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }

            return first.itemCreationDate < second.itemCreationDate
        }
    }

    var completionAmount: Double {

        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }

        let completedItems = originalItems.filter(\.completed)

        return Double(completedItems.count) / Double(originalItems.count)
    }

    static var example: Project {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext

        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example Project"
        project.closed = true
        project.creationDate = Date()

        return project
    }

    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .optimized:
           return projectItemsDefaultSorted
        case .title:
//            return project.projectItems.sorted { $0.itemTitle < $1.itemTitle }
            return projectItems.sorted(by: \.itemTitle)
        case .creationDate:
//            return project.projectItems.sorted { $0.itemCreationDate < $1.itemCreationDate }
            return projectItems.sorted(by: \.itemCreationDate)
        }
    }

    var label: LocalizedStringKey {
        "\(projectTitle), \(projectItems.count) items, \(completionAmount * 100, specifier: "%g")% complete"
    }

}
