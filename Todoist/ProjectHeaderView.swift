//
//  ProjectHeaderView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 26.01.22.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                ProgressView(value: project.completionAmount)
            }

            Spacer()

            NavigationLink(destination: EmptyView()) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
    }
}


//
//struct ProjectHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectHeaderView()
//    }
//}