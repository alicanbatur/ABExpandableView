//
//  RowItem.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 15/12/2017.
//

import Foundation

public protocol RowItem: class {
    var identifier: String! { get }
    var name: String! { get }
}
