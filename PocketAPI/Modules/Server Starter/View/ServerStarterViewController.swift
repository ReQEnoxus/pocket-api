//
//  ServerStarterViewController.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ServerStarterViewController: UIViewController, ServerStarterViewInput {
    
    private class Appearance {
        
        static let startButtonCornerRadius: CGFloat = 16
        static let startButtonTitle = "Start Server"
        static let closeButtonTitle = "Close"
        
        static let promptFontName = "Futura-Medium"
        static let promptFontSize: CGFloat = 16
        
        static let startButtonHeight = 50
        
        static let startButtonFont = "Futura-Bold"
        static let startButtonFontSize: CGFloat = 20
        
        static let contentLeftOffset = 16
        static let contentTopOffset = 16
        static let contentRightOffset = 16
        static let contentSpacing = 8
    }
    
    var presenter: ServerStarterViewOutput!
    
    lazy var mainScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    lazy var startButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Appearance.startButtonCornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Appearance.startButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(serverToggled), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: Appearance.startButtonFont, size: Appearance.startButtonFontSize)
        
        return button
    }()
    
    lazy var promptLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: Appearance.promptFontName, size: Appearance.promptFontSize)
        label.textColor = .systemGray
        label.numberOfLines = .zero
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var documentationLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: Appearance.promptFontName, size: Appearance.promptFontSize)
        label.textColor = .systemGray
        label.numberOfLines = .zero
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        
        let item = UIBarButtonItem(title: Appearance.closeButtonTitle, style: .plain, target: self, action: #selector(closeButtonTapped))
        
        item.tintColor = .systemGreen
        
        return item
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        
        return loadingIndicator
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .systemBackground
        view.backgroundColor = .systemBackground
        
        setupViewHierarchy()
        setupConstraints()
        
        presenter.initialSetup()
    }
    
    func setupViewHierarchy() {
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(startButton)
        mainScrollView.addSubview(promptLabel)
        mainScrollView.addSubview(documentationLabel)
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func setupConstraints() {
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            
            make.left.equalTo(view).offset(Appearance.contentLeftOffset)
            make.top.equalTo(view).offset(Appearance.contentTopOffset)
            make.right.equalTo(view).inset(Appearance.contentRightOffset)
            make.height.equalTo(Appearance.startButtonHeight)
        }
        
        promptLabel.snp.makeConstraints { make in
            
            make.left.equalTo(view).offset(Appearance.contentLeftOffset)
            make.top.equalTo(startButton.snp.bottom).offset(Appearance.contentSpacing)
            make.right.equalTo(view).inset(Appearance.contentRightOffset)
        }
        
        documentationLabel.snp.makeConstraints { make in
            
            make.left.equalTo(view).offset(Appearance.contentLeftOffset)
            make.top.equalTo(promptLabel.snp.bottom).offset(Appearance.contentSpacing)
            make.right.equalTo(view).inset(Appearance.contentRightOffset)
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - View Input
    func updatePrompt(with message: String) {
        promptLabel.text = message
    }
    
    func updateButton(with title: String) {
        startButton.setTitle(title, for: .normal)
    }
    
    func setDocumentation(_ docs: String) {
        documentationLabel.text = docs
    }
    
    func setLoading(_ loading: Bool) {
        
        if loading {
            
            startButton.setTitle(.none, for: .normal)
            
            startButton.isEnabled = false
            
            startButton.addSubview(loadingIndicator)
            
            loadingIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            loadingIndicator.startAnimating()
        }
        else {
            
            startButton.isEnabled = true
            
            loadingIndicator.stopAnimating()
            
            if startButton.subviews.contains(loadingIndicator) {
                loadingIndicator.removeFromSuperview()
            }
        }
    }
    
    //MARK: - objc selectors
    @objc func serverToggled() {
        presenter.serverToggle()
    }
    
    @objc func closeButtonTapped() {
        presenter.closeButtonTapped()
    }
}
