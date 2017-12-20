//
//  ExpandableSectionsViewController.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 14/12/2017.
//

import UIKit

open class ExpandableSectionsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var warningLabel: UILabel!
    
    // MARK: - Creation
    
    open class func newInstance() -> ExpandableSectionsViewController {
        let bundle = Bundle(for: ExpandableSectionsViewController.self)
        let storyboard = UIStoryboard(name: "Expandable", bundle: bundle)
        return storyboard.instantiateInitialViewController() as! ExpandableSectionsViewController
    }
    
    // MARK: - View Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    // MARK: - Keyboard Helpers
    
    private func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - UITableViewDelegate

extension ExpandableSectionsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        viewModel.selectItem(at: indexPath)
        //        updateSelectedItemsCountValue(on: nil, tableView: tableView, section: indexPath.section)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //        viewModel.deSelectItem(at: indexPath)
        //        updateSelectedItemsCountValue(on: nil, tableView: tableView, section: indexPath.section)
    }
    
}

// MARK: - UITableViewDataSource

extension ExpandableSectionsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        //        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //        return viewModel.numberOfRows(at: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.reuseIdentifier, for: indexPath) as! SelectionCell
        cell.populateCell("test")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        if viewModel.shouldSelectCell(at: indexPath) {
        //            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        //        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = Bundle.main.loadNibNamed("ExpandableHeaderView", owner: self, options: nil)?.first as! ExpandableHeaderView
        //        sectionHeaderView.headerViewDelegate = self
        //        sectionHeaderView.sectionIndex = section;
        //        sectionHeaderView.updateHeaderTitle(viewModel.nameOfSection(at: section))
        //        sectionHeaderView.rotateArrow(viewModel.isSectionExpanded(section))
        //        updateSelectedItemsCountValue(on: sectionHeaderView, tableView: tableView, section: section)
        return sectionHeaderView
    }
    
}

// MARK: - UISearchBarDelegate

extension ExpandableSectionsViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            //            hideKeyboard()
            return false
        }
        searchBar.setShowsCancelButton(true, animated: true)
        //        viewModel.filterArray(with: (searchBar.text! as NSString), range: range, text: text)
        //        warningLabel.isHidden = !viewModel.hasItems
        tableView.reloadData()
        return true
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}

