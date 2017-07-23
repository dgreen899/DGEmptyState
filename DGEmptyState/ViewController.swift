//
//  ViewController.swift
//  DGEmptyState
//
//  Created by Dameon Green on 7/23/17.
//  Copyright © 2017 ApptasticVoyage. All rights reserved.
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    
    fileprivate let image = UIImage(named: "productSample")!.withRenderingMode(.alwaysTemplate)
    fileprivate let topMessage = "Products"
    fileprivate let bottomMessage = "There are no Products yet...."
    
    fileprivate var rows = [String]()
    fileprivate let cellIdentifier = "Cell"
    
    fileprivate var didSetupConstraints = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupEmptyBackgroundView()
    }
    
    // MARK: - Initialization
    
    func setupTableView() {
        tableView = UITableView.newAutoLayout()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        view.addSubview(tableView)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyStateView(image: image, top: topMessage, bottom: bottomMessage)
        tableView.backgroundView = emptyBackgroundView
    }

    
    // MARK: - Layout
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
            tableView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
            tableView.autoPinEdge(toSuperviewEdge: .leading)
            tableView.autoPinEdge(toSuperviewEdge: .trailing)
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rows.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
}
