//
//  PlaceholderView.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PlaceholderView: UIView {
    
    private class Appearance {
        
        static let promptFontName = "Futura-Medium"
        static let promptFontSize: CGFloat = 15
        static let promptImageName = "cube.box"
        static let promptText = "No models were created yet, pull down to create new!"
        
        static let contentLeftOffset = 32
        static let contentTopOffset = 32
        static let contentRightOffset = 32
        static let contentBottomOffset = 32
        static let contentSpacing = 16
        
        static let promptImageHeight = 400
    }
    
    lazy var promptImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        let image = UIImage(systemName: Appearance.promptImageName)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        return imageView
    }()
    
    lazy var promptTextLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: Appearance.promptFontName, size: Appearance.promptFontSize)
        label.textColor = .systemGray
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = Appearance.promptText
        
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        
        addSubview(promptImageView)
        addSubview(promptTextLabel)
        
        promptImageView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.top.equalToSuperview().offset(Appearance.contentTopOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.height.equalTo(Appearance.promptImageHeight)
        }
        
        promptTextLabel.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.top.equalTo(promptImageView.snp.bottom).offset(Appearance.contentSpacing)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.bottom.equalToSuperview().inset(Appearance.contentBottomOffset)
        }
    }
}
