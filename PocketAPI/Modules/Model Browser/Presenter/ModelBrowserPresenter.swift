//
//  ModelBrowserPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 24.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

class ModelBrowserPresenter: ModelBrowserViewOutput, ModelBrowserInteractorOutput, ModelBrowserDataSourceDelegate {
    
    weak var view: ModelBrowserViewInput!
    var dataSource: ModelBrowserDataSource!
    var router: ModelBrowserRouterInput!
    var interactor: ModelBrowserInteractorInput!
    
    private var indexPathToDelete: IndexPath?
    
    func initialSetup() {
        
        view.registerDataSource(dataSource)
        view.reloadData()
        view.displayTableView()
        interactor.subscribeToTypeCreationNotifications()
        interactor.subscribeToServerStateNotifications()
        interactor.loadInitialTypes()
    }
    
    func didPullTable() {
        
        if dataSource.isMutable {
            router.presentModelCreator(usedNames: dataSource.models.map({ $0.name }))
        }
        else {
            router.showErrorAlert(message: "You need to disable the server before adding new models")
        }
    }
    
    func didPressedStartServer() {
        router.presentServerStarter(types: dataSource.types)
    }
    
    //MARK: - Interactor Output
    func didReceiveNotification(with type: Type) {
        
        dataSource.types.append(type)
        
        let fieldsString = type.attributes.compactMap { (key, value) -> String? in
            
            let representation = TypeFormatter.representation(of: value)
            
            return "\(key): \(representation)"
        }.joined(separator: "\n")
        
        let endpointsString = "@GET /\(type.name.lowercased())\n@GET /\(type.name.lowercased())/{id}\n@POST /\(type.name.lowercased())\n@DELETE /\(type.name.lowercased())/{id}"
        
        let viewModel = ViewModel(name: type.name, fields: fieldsString, endpoints: endpointsString)
        
        let indexToAdd = IndexPath(row: dataSource.models.count, section: .zero)
        
        let modelCount = dataSource.models.count
        
        dataSource.models.append(viewModel)
        
        if modelCount == .zero {
            view.reloadData()
        }
        else {
            view.updateTableView(deletions: [], insertions: [indexToAdd], modifications: [])
        }
        
        view.setShowingPlaceholder(false)
    }
    
    func didFinishTaskWith(error: Error) {
        router.showErrorAlert(message: error.localizedDescription)
    }
    
    func didLoadInitialTypes(_ types: [Type]) {
        guard !types.isEmpty else { return }
        
        dataSource.types += types
        
        types.forEach { type in
            let fieldsString = type.attributes.compactMap { (key, value) -> String? in
                
                let representation = TypeFormatter.representation(of: value)
                
                return "\(key): \(representation)"
            }.joined(separator: "\n")
            
            let endpointsString = "@GET /\(type.name.lowercased())\n@GET /\(type.name.lowercased())/{id}\n@POST /\(type.name.lowercased())\n@DELETE /\(type.name.lowercased())/{id}"
            
            let viewModel = ViewModel(name: type.name, fields: fieldsString, endpoints: endpointsString)
            
            dataSource.models.append(viewModel)
        }
        
        view.reloadData()
        view.setShowingPlaceholder(false)
    }
    
    func didReceiveServerStateChangeNotification(shouldTurnImmutable: Bool) {
        
        if shouldTurnImmutable {
            dataSource.isMutable = false
        }
        else {
            dataSource.isMutable = true
        }
    }
    
    func didDeleteItemSuccessfully() {
        guard let indexPath = indexPathToDelete else { return }
        dataSource.delete(at: indexPath)
        view.updateTableView(deletions: [indexPath], insertions: [], modifications: [])
        indexPathToDelete = nil
        
        if dataSource.models.isEmpty {
            view.setShowingPlaceholder(true)
        }
    }
    
    //MARK: - ModelBrowserDataSource Delegate
    func didRequestToDelete(type: Type, at: IndexPath) {
        indexPathToDelete = at
        interactor.deleteType(by: type.name)
    }
}
