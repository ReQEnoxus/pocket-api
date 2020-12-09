//
//  Documentation.swift
//  PocketAPI
//
//  Created by Enoxus on 28.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// set of documentation entries
struct Documentation {
    let entries: [DocumentationEntry]
}

/// endpoint and its description
struct DocumentationEntry {
    
    let endpoint: String
    let description: String
}
