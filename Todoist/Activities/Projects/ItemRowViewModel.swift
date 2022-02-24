//
//  ItemRowViewModel.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 24.02.22.
//

import Foundation

extension ItemRowView {
    final class ViewModel: ObservableObject {
        let project: Project
        let item: Item

        var title: String {
            item.itemTitle
        }

        var label: String {
            if item.completed {
                return String("\(item.itemTitle), completed.")
            } else if item.priority == 3 {
                return String("\(item.itemTitle), high priority.")
            } else {
                return String(item.itemTitle)
            }
        }

        var icon: String {
            if item.completed {
                return "checkmark.circle"
            } else if item.priority == 3 {
               return "exclamationmark.triangle"
            } else {
                return "checkmark.circle"
            }
        }

        var color: String? {
            if item.completed {
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return nil
            }
        }

        init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
    }
}
