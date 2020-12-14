//
//  TypeConstructorViewOutput.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol TypeConstructorViewOutput: AnyObject {
    func cancel()
    func submit()
    func reset()
    func loadTypes()
    func didSelect(category: SectionCategory, index: Int)
}
