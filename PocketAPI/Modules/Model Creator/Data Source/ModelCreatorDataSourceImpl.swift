//
//  ModelCreatorDataSourceImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ModelCreatorDataSourceImpl: NSObject, ModelCreatorDataSource {
    
    var models: [NameTypePair] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nibName, for: indexPath)
        
        cell.textLabel?.text = "\(models[indexPath.row].name): \(models[indexPath.row].type)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
