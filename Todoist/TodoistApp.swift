//
//  TodoistApp.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 19.01.22.
//

import SwiftUI

@main
struct TodoistApp: App {

    @StateObject var dataController: DataController

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
