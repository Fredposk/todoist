//
//  HomeView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 21.01.22.
//

import SwiftUI



struct HomeView: View {

    static let tag: String? = "Home"
    @EnvironmentObject var dataController: DataController


    var body: some View {
        NavigationView{
            VStack {
                Button("add data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
