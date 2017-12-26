//
//  ExpandableHeaderView.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 15/12/2017.
//

import Foundation

protocol HeaderViewDelegate: class {
    func didTap(headerView: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var selectedItemCountLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    private var section: Int?

    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Creation
    
    open class func newInstance(_ section: Int, delegate: HeaderViewDelegate, title: String, shouldRotateArrow: Bool) -> ExpandableHeaderView {
        let bundle = Bundle(for: ExpandableHeaderView.self)
        let view = bundle.loadNibNamed("ExpandableHeaderView", owner: self, options: nil)?.first as! ExpandableHeaderView
        view.addGesture()
        view.section = section
        view.delegate = delegate
        view.title = title
        view.rotateArrow(shouldRotateArrow)
        return view
    }
    
    // MARK: - Public helpers
    
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
    
    func rotateArrow(_ up: Bool) {
        if up {
            arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    // MARK: - Private Helpers
    
    private func addGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExpandableHeaderView.headerViewTapped(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - IBAction
    
    @IBAction func headerViewTapped(_ sender: Any) {
        guard let section = section else { return }
        delegate?.didTap(headerView: self, section: section)
    }
    
}

