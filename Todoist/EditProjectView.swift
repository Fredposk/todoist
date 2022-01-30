//
//  EditProjectView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 30.01.22.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project

    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String
    @State private var detail: String
    @State private var colour: String

    @State private var showConfirmDelete = false

    let colorColumns = [GridItem(.adaptive(minimum: 44))]


    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _colour = State(wrappedValue: project.projectColor)
    }

    var body: some View {
        Form {

            Section(header: Text("Basic settings")) {
                TextField("Project name", text: $title.onChange(update))
                TextField("Description of this project", text: $detail.onChange(update))
            }

            Section(header: Text("Custom Project Colour")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colours, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            if item == colour {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .onTapGesture {
                            colour = item
                            update()
                        }
                    }
                }
                .padding()
            }

            Section(footer: Text("Closing a Project moves it from the open tab; deleting it removes the project entirely")) {
                Button(project.closed ? "Reopen this project" : "Close this Project") {
                    project.closed.toggle()
                    update()
                }
                Button("Delete this project") {
                    showConfirmDelete.toggle()
                }.accentColor(.red)
            }
            
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showConfirmDelete) {
            Alert(title: Text("Delete Project?"), message: Text("Are you sure you want to delete this project, deleting also deletes all items"), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
    }

    func update() {
        project.title = title
        project.detail = detail
        project.color = colour
    }

    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

//struct EditProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProjectView()
//    }
//}
