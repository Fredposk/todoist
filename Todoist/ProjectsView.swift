//
//  ProjectsView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 21.01.22.
//

import SwiftUI

struct ProjectsView: View {

    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"

    let showClosedProjects: Bool
    let projects: FetchRequest<Project>

    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects

        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }


    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.projectTitle)) {
                        ForEach(project.projectItems) { item in
                            Text(item.itemTitle)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            }
        }
    }
}

//struct ProjectsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectsView()
//    }
//}
