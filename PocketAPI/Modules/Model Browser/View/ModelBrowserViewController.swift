//
//  ModelBrowserViewController.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class ModelBrowserViewController: UIViewController, ModelBrowserViewInput {
    
    private class Appearance {
        
        static let startServerButtonImageName = "play.circle"
        static let title = "PocketAPI"
        
        static let placeholderOffset = 16
    }
    
    var presenter: ModelBrowserViewOutput!
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(cell: ModelViewCell.self)
        
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_ :)), for: .valueChanged)
        
        return refreshControl
    }()
    
    lazy var placeholderView: PlaceholderView = {
        
        return PlaceholderView()
    }()
    
    lazy var startServerButton: UIBarButtonItem = {
        
        let item = UIBarButtonItem(image: UIImage(systemName: Appearance.startServerButtonImageName)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didPressStartServer))
        
        return item
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = UIRectEdge.top
        
        view.backgroundColor = .systemGray6
        
        configureNavigationBar(largeTitleColor: .systemGreen, backgroundColor: .systemBackground, tintColor: .systemBackground, title: Appearance.title, preferredLargeTitle: false)
        setupTableView()
        configurePlaceHolder()
        
        navigationItem.rightBarButtonItem = startServerButton
        
        presenter.initialSetup()
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let controlView = AddControlView(frame: .init(x: .zero, y: .zero, width: view.frame.width, height: refreshControl.frame.height))
        
        refreshControl.addSubview(controlView)
        
        tableView.refreshControl = refreshControl
        
        controlView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - View Input
    func registerDataSource(_ dataSource: ModelBrowserDataSource) {
        tableView.dataSource = dataSource
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func updateTableView(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath]) {
        
        tableView.beginUpdates()
        
        tableView.deleteRows(at: deletions, with: .automatic)
        tableView.insertRows(at: insertions, with: .automatic)
        tableView.reloadRows(at: modifications, with: .automatic)
        
        tableView.endUpdates()
    }
    
    func displayTableView() {
        view.addSubview(tableView)
    }
    
    func setShowingPlaceholder(_ showing: Bool) {
        
        if showing {
            placeholderView.alpha = 1
        }
        else {
            placeholderView.alpha = .zero
        }
    }
    
    private func configurePlaceHolder() {
        
        tableView.backgroundView = placeholderView
        
        tableView.backgroundView?.snp.removeConstraints()
        tableView.backgroundView?.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    //MARK: - objc selectors
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        refreshControl.endRefreshing()
        tableView.setContentOffset(.zero, animated: true)
        presenter.didPullTable()
    }
    
    @objc func didPressStartServer() {
        presenter.didPressedStartServer()
    }
}

