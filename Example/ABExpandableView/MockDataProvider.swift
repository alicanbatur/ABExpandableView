//
//  MockDataProvider.swift
//  ABExpandableView_Example
//
//  Created by Ali Can Batur on 25/12/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ABExpandableView

class Town: RowItem {
    var identifier: String!
    var name: String!
    
    init(identifier: String, name: String) {
        self.identifier = identifier
        self.name = name
    }
}

class City: SectionItem {
    
    var identifier: String!
    var name: String!
    
    var expanded: Bool = true
    
    var rows: [RowItem] = [RowItem]()
    var rawRows: [RowItem] = [RowItem]() {
        didSet {
            rows = rawRows
        }
    }
    var selectedRows: [RowItem] = [RowItem]()
    
}

class MockDataProvider {
    
    class func createMockData() -> [SectionItem] {
        var array = [SectionItem]()
        
        let izmir = City()
        izmir.identifier = "35"
        izmir.name = "İzmir"
        let bornova = Town(identifier: "1", name: "Bornova")
        let urla = Town(identifier: "2", name: "Urla")
        let konak = Town(identifier: "3", name: "Konak")
        let izmirRawRows = [bornova, urla, konak]
        izmir.rawRows = izmirRawRows
        array.append(izmir)
        
        let istanbul = City()
        istanbul.identifier = "34"
        istanbul.name = "İstanbul"
        let kadikoy = Town(identifier: "4", name: "Kadıköy")
        let maltepe = Town(identifier: "5", name: "Maltepe")
        let beykoz = Town(identifier: "6", name: "Beykoz")
        let istanbulRawRows = [kadikoy, maltepe, beykoz]
        istanbul.rawRows = istanbulRawRows
        array.append(istanbul)
        
        return array
    }
    
    
}
