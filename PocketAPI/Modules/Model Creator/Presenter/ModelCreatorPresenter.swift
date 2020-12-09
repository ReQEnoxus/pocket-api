//
//  ModelCreatorPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 25.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ModelCreatorPresenter: ModelCreatorViewOutput, ModelCreatorInteractorOutput {
    
    weak var view: ModelCreatorViewInput!
    var dataSource: ModelCreatorDataSource!
    var interactor: ModelCreatorInteractorInput!
    var router: ModelCreatorRouterInput!
    
    var alreadyUsedNames: [String]!
    
    func initialSetup() {
        
        view.connectDataSource(dataSource)
        view.reloadData()
        interactor.subscribeToNameTypePairCreation()
    }
    
    func addButtonPressed() {
        router.presentFieldCreator(dataSource.models.map({ $0.name }))
    }
    
    func submitButtonPressed(name: String?) {
        
        guard let name = name, !name.isEmpty else {
            
            router.showErrorAlert(message: "Please, specify a name for the model")
            return
        }
        if alreadyUsedNames.contains(name) {
            router.showErrorAlert(message: "Please, specify unique name for the model")
        }
        else {
            
            if dataSource.models.isEmpty {
                router.showErrorAlert(message: "Please, specify at least one field to the model")
            }
            else {
                interactor.createTypeAndNotify(name: name.replacingOccurrences(of: " ", with: String()), fields: dataSource.models)
                router.dismiss()
            }
        }
    }
    
    func cancelButtonPressed() {
        router.dismiss()
    }
    
    //MARK: - Interactor Output
    func didReceiveNotification(for nameTypePair: NameTypePair) {
        
        if !dataSource.models.contains(where: { $0.name == nameTypePair.name }) {
            
            let indexToAdd = IndexPath(row: dataSource.models.count, section: .zero)
            dataSource.models.append(nameTypePair)
            
            view.updateTableView(deletions: [], insertions: [indexToAdd], modifications: [])
        }
    }
}
