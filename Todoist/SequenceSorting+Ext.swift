//
//  SequenceSorting+Ext.swift
//  Todoist
//
//  Created by Frederico Kuckelhaus on 01.02.22.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        self.sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }
}
