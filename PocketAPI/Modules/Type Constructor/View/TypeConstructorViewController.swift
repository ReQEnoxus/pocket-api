//
//  TypeConstructorViewController.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

final class TypeConstructorViewController: UIViewController {
    
    private class Appearance {
        static let submitButtonTitle = "Submit"
        static let resetButtonImage = "arrow.counterclockwise"
        static let cancelButtonTitle = "Cancel"
        static let typeLabelPlaceholder = "Select type"
    }
    
    var viewModel: AvailableTypesViewModel = AvailableTypesViewModel(sections: [])
    var presenter: TypeConstructorViewOutput!
    private let typeConstructorView: TypeConstructorView
    
    override func loadView() {
        view = typeConstructorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupTableView()
        setupNavigationBar()
        presenter.loadTypes()
    }
    
    init() {
        typeConstructorView = TypeConstructorView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        let submitButton = UIBarButtonItem(title: Appearance.submitButtonTitle, style: .done, target: self, action: #selector(submitButtonTapped))
        let resetButton = UIBarButtonItem(image: UIImage(systemName: Appearance.resetButtonImage), style: .plain, target: self, action: #selector(resetButtonTapped))
        let cancelButton = UIBarButtonItem(title: Appearance.cancelButtonTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        [submitButton, resetButton, cancelButton].forEach { $0.tintColor = .systemGreen }
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItems = [submitButton, resetButton]
    }
    
    private func setupTableView() {
        typeConstructorView.tableView.dataSource = self
        typeConstructorView.tableView.delegate = self
        typeConstructorView.tableView.register(cell: UITableViewCell.self)
    }
    
    //MARK: - objc selectors
    @objc private func submitButtonTapped() {
        presenter.submit()
    }
    
    @objc private func resetButtonTapped() {
        presenter.reset()
    }
    
    @objc private func cancelButtonTapped() {
        presenter.cancel()
    }
}

extension TypeConstructorViewController: TypeConstructorViewInput {
    func display(type: String) {
        typeConstructorView.typeLabel.text = type
    }
    
    func display(viewModel: AvailableTypesViewModel) {
        self.viewModel = viewModel
        typeConstructorView.tableView.reloadData()
    }
    
    func reset() {
        typeConstructorView.typeLabel.text = Appearance.typeLabelPlaceholder
    }
}

extension TypeConstructorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].count != .zero ? viewModel.sections[section].category.rawValue : nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = viewModel.sections[indexPath.section].types[indexPath.row].name
        
        return cell
    }
}

extension TypeConstructorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(category: viewModel.sections[indexPath.section].category, index: indexPath.row)
    }
}
