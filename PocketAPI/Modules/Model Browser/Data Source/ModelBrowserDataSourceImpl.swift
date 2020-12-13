//
//  ModelBrowserDataSourceImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Entity

class ModelBrowserDataSourceImpl: NSObject, ModelBrowserDataSource {
    
    var isMutable = true
    
    var models: [ViewModel] = []
    var types: [Type] = []
    
    weak var delegate: ModelBrowserDataSourceDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelViewCell.nibName, for: indexPath) as! ModelViewCell
        
        cell.entityNameLabel.text = models[indexPath.row].name
        cell.entityFieldsLabel.text = models[indexPath.row].fields
        cell.entityEndpointsLabel.text = models[indexPath.row].endpoints
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let type = types[indexPath.row]
            delegate?.didRequestToDelete(type: type, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isMutable
    }
    
    func delete(at indexPath: IndexPath) {
        models.remove(at: indexPath.row)
        types.remove(at: indexPath.row)
    }
}
