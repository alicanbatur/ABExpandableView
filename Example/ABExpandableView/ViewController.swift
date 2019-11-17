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
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - IBAction
    
    @IBAction func buttonTapped(_ sender: Any) {
        let expandableSectionsViewModel = ExpandableSectionsViewModel(MockDataProvider.createMockData())
        let expandableSectionViewController = ExpandableSectionsViewController.newInstance(expandableSectionsViewModel)
        expandableSectionViewController.title = "Choose Town(s)"
        expandableSectionViewController.delegate = self
        self.navigationController?.pushViewController(expandableSectionViewController, animated: true)
    }
}

extension ViewController: ExpandableSectionsViewControllerDelegate {
    
    func didSelectItems(_ items: [RowItem]) {
        let names = items.compactMap { $0.name }.joined(separator: ", ")
        textView.text = names
    }
    
}

