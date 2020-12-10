//
//  AvailableTypesViewModel.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

struct AvailableTypesViewModel {
    let sections: [TypeSection]
}

struct TypeSection {
    let category: SectionCategory
    let types: [TypeCellViewModel]
    
    var count: Int { types.count }
}

enum SectionCategory: String {
    case primitive = "Primitive"
    case custom = "Custom"
    case array = "Array"
}
