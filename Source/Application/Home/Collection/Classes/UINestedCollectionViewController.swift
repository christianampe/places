//
//  UINestedCollectionViewController.swift
//  Places
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

protocol UINestedCollectionViewDataSource: class {
    func numberOfRows(in tableView: UITableView) -> Int
    
    func tableView(_ tableView: UITableView,
                   viewModelsFor row: Int) -> [UINestedCollectionViewRowCellViewModel]
    
    func tableView(_ tableView: UITableView,
                   titleFor row: Int) -> String
}

protocol UINestedCollectionViewDelegate: class {
    func tableView(_ tableView: UITableView,
                   didRespondToPanGesture sender: UIPanGestureRecognizer)
    
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath)
}

extension UINestedCollectionViewDelegate {
    func tableView(_ tableView: UITableView,
                   didRespondToPanGesture sender: UIPanGestureRecognizer) {}
    
    func tableView(_ tableView: UITableView,
                   didDisplayItemAt indexPath: IndexPath) {}
}

class UINestedCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: UINestedCollectionViewDelegate?
    weak var dataSource: UINestedCollectionViewDataSource?
    
    var currentIndexPath = IndexPath(item: 0, section: 0)
}

extension UINestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
    }
    
    func focus(indexPath: IndexPath) {
        let requestedTableViewIndexPath = IndexPath(row: 0, section: indexPath.section)
        
        guard let cell = tableView.cellForRow(at: requestedTableViewIndexPath) as? UINestedCollectionViewColumnCell else {
            assertionFailure("incorrect cell type used")
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.section), at: .top, animated: true)
        cell.focus(index: indexPath.row)
    }
}

// MARK: - Lifecycle
extension UINestedCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
}

private extension UINestedCollectionViewController {
    func setUpTableView() {
        tableView.decelerationRate = .fast
        tableView.sectionHeaderHeight = UINestedCollectionViewController.headerHeight
        tableView.rowHeight = UINestedCollectionViewController.rowHeight
        tableView.sectionFooterHeight = UINestedCollectionViewController.footerHeight
        tableView.panGestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
    }
}

// MARK: - Gesure Handlers
extension UINestedCollectionViewController {
    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        delegate?.tableView(tableView, didRespondToPanGesture: sender)
    }
}

// MARK: - UITableViewDataSource
extension UINestedCollectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfRows(in: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as UINestedCollectionViewColumnCell
        
        guard let viewModels = dataSource?.tableView(tableView, viewModelsFor: indexPath.section) else {
            return cell
        }
        
        cell.set(properties: viewModels)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return dataSource?.tableView(tableView,
                                     titleFor: section)
    }
}

// MARK: - UITableViewDelegate
extension UINestedCollectionViewController: UITableViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let verticalVelocity = velocity.y
        let rowHeight = UINestedCollectionViewController.cellHeight
        var itemIndex = round(scrollView.contentOffset.y / rowHeight)
        
        if verticalVelocity > 0 {
            itemIndex += 1
        } else if verticalVelocity < 0 {
            itemIndex -= 1
        }
        
        targetContentOffset.pointee.y = itemIndex * rowHeight
        currentIndexPath.section = Int(itemIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.tableView(tableView,
                            didDisplayItemAt: currentIndexPath)
    }
}

extension UINestedCollectionViewController: UINestedCollectionViewColumnCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didDisplayCellAt index: Int) {
        
        currentIndexPath.row = index
        
        delegate?.tableView(tableView,
                            didDisplayItemAt: currentIndexPath)
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewController {
    static let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    static let rowHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    static let footerHeight: CGFloat = 0.0
    static let cellHeight: CGFloat =
        UINestedCollectionViewController.rowHeight +
        UINestedCollectionViewController.headerHeight +
        UINestedCollectionViewController.footerHeight
}
