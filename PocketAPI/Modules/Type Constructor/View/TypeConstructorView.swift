//
//  TypeConstructorView.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

final class TypeConstructorView: UIView {
    
    private class Appearance {
        static let contentOffset = 8
        static let typeLabelHeight = 150
    }
    
    lazy var labelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-Bold", size: 24)
        label.textAlignment = .center
        label.textColor = .systemGreen
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = UIView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(labelContainer)
        labelContainer.addSubview(typeLabel)
        addSubview(tableView)
    }
    
    private func makeConstraints() {
        labelContainer.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Appearance.typeLabelHeight)
        }
        typeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelContainer.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
