//
//  UINestedCollectionViewController.swift
//  Places
//
//  Created by Christian Ampe on 5/13/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit

class UINestedCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: UINestedCollectionViewDelegate?
    weak var dataSource: UINestedCollectionViewDataSource?
}

extension UINestedCollectionViewController {
    func reloadData() {
        tableView.reloadData()
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
        
        guard let viewModels = dataSource?.tableView(tableView, viewModelsFor: indexPath.row) else {
            return cell
        }
        
        cell.set(properties: viewModels)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return "Popular"
    }
}

// MARK: - UITableViewDelegate
extension UINestedCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        return UINestedCollectionViewController.headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UINestedCollectionViewController.rowHeight
    }
}

// MARK: - Static Properties
extension UINestedCollectionViewController {
    static let cellHeight: CGFloat = UINestedCollectionViewController.rowHeight + UINestedCollectionViewController.headerHeight
    private static let rowHeight: CGFloat = UIScreen.main.bounds.height * 0.2
    private static let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.05
}
