//
//  ExpandableHeaderView.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 15/12/2017.
//

import Foundation

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var selectedItemCountLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Public vars
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var selectedItemCount: Int = 0 {
        didSet {
            selectedItemCountLabel.isHidden = !(selectedItemCount > 0)
            selectedItemCountLabel.text = String(selectedItemCount)
        }
    }
    
    func rotateArrow(up: Bool) {
        if up {
            arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
}

