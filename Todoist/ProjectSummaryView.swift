//
//  ProjectSummaryView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 09.02.22.
//

import SwiftUI

struct ProjectSummaryView: View {

    let project: Project

    var body: some View {
        VStack(alignment: .leading) {

            Text("\(project.projectItems.count) items")
                .font(.caption)
                .foregroundColor(.secondary)

            Text(LocalizedStringKey(String("\(project.projectTitle)")))
                .font(.title2)


            ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
        }
        .padding()
        .background(Color.secondarySystemGroupedBackground)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.5), radius: 5)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(project.label)
    }
}

//struct ProjectSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectSummaryView()
//    }
//}
