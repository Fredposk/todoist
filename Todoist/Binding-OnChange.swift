//
//  Binding-OnChange.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 26.01.22.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            handler()
        }
    }
}

