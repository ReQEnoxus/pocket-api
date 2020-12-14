//
//  ModelCreatorViewController.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ModelCreatorViewController: UIViewController, ModelCreatorViewInput {
    
    private class Appearance {
        
        static let modelNameTextFieldPlaceholder = "Name of the model"
        static let addFieldButtonImageName = "plus.circle"
        
        static let contentLeftOffset = 16
        static let contentTopOffset = 16
        static let contentRightOffset = 16
        static let contentSpacing = 8
        
        static let submitButtonTitle = "Create"
        static let cancelButtonTitle = "Cancel"
        
        static let buttonSize = 30
    }
    
    lazy var modelNameTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = Appearance.modelNameTextFieldPlaceholder
        textField.tintColor = .systemGreen
        textField.keyboardType = .asciiCapable
        
        return textField
    }()
    
    lazy var addFieldButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: Appearance.addFieldButtonImageName)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addFieldButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(cell: UITableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        
        let item = UIBarButtonItem(title: Appearance.cancelButtonTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        item.tintColor = .systemGreen
        
        return item
    }()
    
    lazy var submitButton: UIBarButtonItem = {
        
        let item = UIBarButtonItem(title: Appearance.submitButtonTitle, style: .done, target: self, action: #selector(submitButtonTapped))
        
        item.tintColor = .systemGreen
        
        return item
    }()
    
    var presenter: ModelCreatorViewOutput!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        
        setupViewHierarchy()
        setupConstraints()
        presenter.initialSetup()
    }
    
    //MARK: - View Input
    func connectDataSource(_ dataSource: ModelCreatorDataSource) {
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
    
    //MARK: - Setup
    private func setupViewHierarchy() {
        
        view.addSubview(modelNameTextField)
        view.addSubview(addFieldButton)
        view.addSubview(tableView)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = submitButton
    }
    
    private func setupConstraints() {
        
        modelNameTextField.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(Appearance.contentTopOffset)
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
        }
        
        addFieldButton.snp.makeConstraints { make in
            
            make.top.equalTo(modelNameTextField.snp.bottom).offset(Appearance.contentTopOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.width.equalTo(Appearance.buttonSize)
            make.height.equalTo(Appearance.buttonSize)
        }
        
        tableView.snp.makeConstraints { make in
            
            make.top.equalTo(addFieldButton.snp.bottom).offset(Appearance.contentSpacing)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - objc selectors
    @objc func cancelButtonTapped() {
        presenter.cancelButtonPressed()
    }
    
    @objc func submitButtonTapped() {
        presenter.submitButtonPressed(name: modelNameTextField.text)
    }
    
    @objc func addFieldButtonTapped() {
        presenter.addButtonPressed()
    }
}
