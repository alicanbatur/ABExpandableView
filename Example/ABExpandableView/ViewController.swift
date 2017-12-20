//
//  ViewController.swift
//  ABExpandableView
//
//  Created by alicanbatur on 12/14/2017.
//  Copyright (c) 2017 alicanbatur. All rights reserved.
//

import UIKit
import ABExpandableView

class ViewController: UIViewController {

    // MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: Any) {
        let asd = ExpandableSectionsViewController.newInstance()
        self.navigationController?.pushViewController(asd, animated: true)
    }
}

