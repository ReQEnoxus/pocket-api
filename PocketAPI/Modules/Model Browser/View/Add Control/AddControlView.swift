//
//  AddControlView.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AddControlView: UIView {
    
    private class Appearance {
        
        static let contolImageName = "plus.rectangle"
        static let controlImageHeightMultiplier = 0.5
        static let controlImageWidthMultiplier = 1.2
    }
    
    lazy var plusSign: UIImageView = {
        
        let imageView = UIImageView()
        let image = UIImage(systemName: Appearance.contolImageName)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
        imageView.image = image
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .systemGray6
        addSubview(plusSign)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        plusSign.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Appearance.controlImageHeightMultiplier)
            make.width.equalTo(plusSign.snp.height).multipliedBy(Appearance.controlImageWidthMultiplier)
        }
    }
}
