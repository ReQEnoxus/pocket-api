//
//  ModelViewCell.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

class ModelViewCell: UITableViewCell {
    
    private class Appearance {
        
        static let defaultFontName = "Futura-Medium"
        static let entityFieldsFontSize: CGFloat = 17
        static let entityEndpointsFontSize: CGFloat = 14
        
        static let containerCornerRadius: CGFloat = 30
        static let entityNameFont = "Futura-Bold"
        static let entityNameFontSize: CGFloat = 20
        static let entityNameNumberOfLines = 1
        
        static let contentLeftOffset = 16
        static let contentRightOffset = 16
        static let contentTopOffset = 16
        static let contentBottomOffset = 16
        static let contentSpacing: CGFloat = 8
    }
    
    lazy var containerView: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = Appearance.containerCornerRadius
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        
        let view = UIStackView()
        
        view.spacing = Appearance.contentSpacing
        view.axis = .vertical
        view.alignment = .leading
        
        return view
    }()
    
    lazy var entityNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: Appearance.entityNameFont, size: Appearance.entityNameFontSize)
        label.textColor = .systemGreen
        label.numberOfLines = Appearance.entityNameNumberOfLines
        
        return label
    }()
    
    lazy var entityFieldsLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont(name: Appearance.defaultFontName, size: Appearance.entityFieldsFontSize)
        
        return label
    }()
    
    lazy var entityEndpointsLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont(name: Appearance.defaultFontName, size: Appearance.entityEndpointsFontSize)
        label.textColor = .systemGray
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(entityNameLabel)
        contentStackView.addArrangedSubview(entityFieldsLabel)
        contentStackView.addArrangedSubview(entityEndpointsLabel)
        
        containerView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.top.equalToSuperview().offset(Appearance.contentTopOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.bottom.equalToSuperview().inset(Appearance.contentBottomOffset)
        }
        
        contentStackView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.top.equalToSuperview().offset(Appearance.contentTopOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.bottom.equalToSuperview().inset(Appearance.contentBottomOffset)
        }
    }
}
