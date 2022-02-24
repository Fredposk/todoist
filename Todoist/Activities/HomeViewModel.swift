//
//  HomeViewModel.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 24.02.22.
//

import Foundation
import CoreData

extension HomeView {
    final class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectsController: NSFetchedResultsController<Project>
        private let itemsController: NSFetchedResultsController<Item>

        @Published var projects = [Project]()
        @Published var items = [Item]()

        private var dataController: DataController!

        var upNext: ArraySlice<Item> {
            items.prefix(3)
        }

        var moreToExplore: ArraySlice<Item> {
            items.dropFirst(3)
        }

        init(dataController: DataController) {
            self.dataController = dataController

            let projectRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectRequest.predicate = NSPredicate(format: "closed = false")
            projectRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: true)]

            projectsController = NSFetchedResultsController(fetchRequest: projectRequest,
                                                            managedObjectContext: dataController.container.viewContext,
                                                            sectionNameKeyPath: nil, cacheName: nil)

            let request: NSFetchRequest<Item> = Item.fetchRequest()
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundedPredicate = NSCompoundPredicate(type: .and,
                                                          subpredicates: [completedPredicate, openPredicate])
            request.predicate = compoundedPredicate
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.priority, ascending: false)]
            request.fetchLimit = 10

            itemsController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: dataController.container.viewContext,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
            super.init()
            projectsController.delegate = self
            itemsController.delegate = self

            do {
                try projectsController.performFetch()
                try itemsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
                items = itemsController.fetchedObjects ?? []
            } catch {
                print("failed getting \(error.localizedDescription)")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Item] {
                items = newItems
            } else if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }

        func addSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }

    }
}
