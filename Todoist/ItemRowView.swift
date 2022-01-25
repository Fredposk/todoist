//
//  ItemRowView.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 25.01.22.
//

import SwiftUI

struct ItemRowView: View {
    
    @ObservedObject var item: Item
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Label("\(item.itemTitle)", systemImage: "folder")
        }
    }
}

//struct ItemRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRowView()
//    }
//}
