//
//  ExpandableSectionsViewController.swift
//  ABExpandableView
//
//  Created by Ali Can Batur on 14/12/2017.
//

import UIKit

public protocol ExpandableSectionsViewControllerDelegate: class {
    func didSelectItems<T>(_ items: [T])
}

open class ExpandableSectionsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var warningLabel: UILabel!
    
    private var viewModel: ExpandableSectionsViewModel!
    
    open weak var delegate: ExpandableSectionsViewControllerDelegate?
    
    // MARK: - Creation
    
    open class func newInstance(_ viewModel: ExpandableSectionsViewModel) -> ExpandableSectionsViewController {
        let bundle = Bundle(for: ExpandableSectionsViewController.self)
        let storyboard = UIStoryboard(name: "Expandable", bundle: bundle)
        let expandableSectionsViewController = storyboard.instantiateInitialViewController() as! ExpandableSectionsViewController
        expandableSectionsViewController.viewModel = viewModel
        return expandableSectionsViewController
    }
    
    // MARK: - View Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
    }
    
    // MARK: - Keyboard Helpers
    
    private func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Private UI Helpers
    
    private func updateSelectedItemsCountValue(on headerView: ExpandableHeaderView?, tableView: UITableView, section: Int) {
        var sectionHeader = headerView
        if headerView == nil {
            sectionHeader = tableView.headerView(forSection: section) as? ExpandableHeaderView
        }
        guard let header = sectionHeader else { return }
        header.selectedItemCount = viewModel.numberOfSelectedItems(at: section)
    }
    
    // MARK: - IBAction
    
    @IBAction func applyBarButtonTapped(_ sender: Any) {
        let items = viewModel.selectedItems()
        delegate?.didSelectItems(items)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension ExpandableSectionsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
        updateSelectedItemsCountValue(on: nil, tableView: tableView, section: indexPath.section)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.deSelectItem(at: indexPath)
        updateSelectedItemsCountValue(on: nil, tableView: tableView, section: indexPath.section)
    }
    
}

// MARK: - UITableViewDataSource

extension ExpandableSectionsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.reuseIdentifier, for: indexPath) as! SelectionCell
        cell.populateCell(viewModel.name(at: indexPath))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.shouldSelectCell(at: indexPath) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = ExpandableHeaderView.newInstance()
        sectionHeaderView.title = viewModel.name(at: section)
        sectionHeaderView.rotateArrow(viewModel.isSectionExpanded(section))
        updateSelectedItemsCountValue(on: sectionHeaderView, tableView: tableView, section: section)
        return sectionHeaderView
    }
    
}

// MARK: - UISearchBarDelegate

extension ExpandableSectionsViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            hideKeyboard()
            return false
        }
        searchBar.setShowsCancelButton(true, animated: true)
        viewModel.filterArray(with: (searchBar.text! as NSString), range: range, text: text)
        warningLabel.isHidden = !viewModel.hasItems
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

