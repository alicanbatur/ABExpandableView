//
//  ExpandableSectionsViewModel.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 20/12/2017.
//

import Foundation

public protocol ExpandableSectionsViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
    func name(at section: Int) -> String
    func name(at indexPath: IndexPath) -> String
    
    func filterArray(with castedText: NSString, range: NSRange, text: String)
}

public class ExpandableSectionsViewModel: ExpandableSectionsViewModelProtocol {
    
    private var items: [SectionItem]
    private var rawItems: [SectionItem]
    
    public init(_ items: [SectionItem]) {
        self.rawItems = items
        self.items = items
    }
    
    // MARK: - Selection Helpers
    
    var hasItems: Bool {
        return items.count == 0
    }
    
    func shouldSelectCell(at indexPath: IndexPath) -> Bool {
        let item = items[indexPath.section]
        let row = item.rows[indexPath.row]
        guard let rawItem = rawItem(identifier: item.identifier) else { return false }
        return rawItem.isSelected(row: row)
    }
    
    func selectItem(at indexPath: IndexPath) {
        let item = items[indexPath.section]
        let row = item.rows[indexPath.row]
        selectItemOfRawItems(section: item, row: row)
    }
    
    func deSelectItem(at indexPath: IndexPath) {
        let item = items[indexPath.section]
        let row = item.rows[indexPath.row]
        deselectItemOfRawItems(section: item, row: row)
    }
    
    func isSectionExpanded(_ section: Int) -> Bool {
        let item = items[section]
        return item.expanded
    }
    
    func numberOfSelectedItems(at section: Int) -> Int {
        let item = items[section]
        guard let rawItem = rawItem(identifier: item.identifier) else { return 0 }
        return rawItem.numberOfSelectedItems()
    }
    
    func selectedItems() -> [RowItem] {
        var items = [RowItem]()
        for item in rawItems {
            items.append(contentsOf: item.selectedRows)
        }
        return items
    }
    
    // MARK: - Private Selection Helpers
    
    private func rawItem(identifier: String) -> SectionItem? {
        if let i = rawItems.index(where: { $0.identifier == identifier }) {
            return rawItems[i]
        }
        return nil
    }
    
    private func selectItemOfRawItems(section: SectionItem, row: RowItem) {
        guard let item = rawItem(identifier: section.identifier) else { return }
        item.select(row: row)
    }
    
    private func deselectItemOfRawItems(section: SectionItem, row: RowItem) {
        guard let item = rawItem(identifier: section.identifier) else { return }
        item.deselect(row: row)
    }
    
    // MARK: - Tableview Datasource Helpers
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfRows(at section: Int) -> Int {
        return items[section].rows.count
    }

    public func name(at section: Int) -> String {
        return items[section].name
    }

    public func name(at indexPath: IndexPath) -> String {
        return items[indexPath.section].rows[indexPath.row].name
    }
    
    // MARK: - SearchBar Text Filtering Helpers
    
    public func filterArray(with castedText: NSString, range: NSRange, text: String) {
        let inputText = castedText.replacingCharacters(in: range, with: text)
        items = rawItems.filter({( item: SectionItem) -> Bool in
            let rows = item.filterRows(inputText: inputText)
            return rows.count != 0
        })
    }
}
