//
//  SectionItem.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 15/12/2017.
//

import Foundation

protocol SectionItem: RowItem {
    var expanded: Bool { get set }
    var rows: [RowItem] { get set }
    var rawRows: [RowItem] { get set }
    var selectedRows: [RowItem] { get set }
    var numberOfSelectedItems: Int { get }
}

/*
 SectionItem extension manages the selection of objects using id comparison.
*/

extension SectionItem {
    
    mutating func select(row: RowItem) {
        if !selectedRows.contains(where: { $0.identifier == row.identifier }) {
            selectedRows.append(row)
        }
    }
    
    mutating func deselect(row: RowItem) {
        selectedRows = selectedRows.filter({ $0.identifier != row.identifier })
    }
    
    func isSelected(row: RowItem) -> Bool {
        return selectedRows.contains(where: { $0.identifier == row.identifier })
    }
    
    mutating func filterRows(inputText: String) -> [RowItem] {
        rows = rawRows.filter({( item: RowItem) -> Bool in
            if inputText == "" { return true }
            return item.name.lowercased().range(of: inputText.lowercased()) != nil
        })
        return rows
    }
    
}
