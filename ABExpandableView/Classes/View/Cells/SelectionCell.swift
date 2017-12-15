//
//  SelectionCell.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 15/12/2017.
//

import Foundation

class SelectionCell: UITableViewCell {
    
    // MARK: - Reuse identifier
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Public helper
    
    func populateCell(_ text: String) {
        textLabel?.text = text
    }
        
}
