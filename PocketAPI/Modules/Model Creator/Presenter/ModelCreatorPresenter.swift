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
    var currentFields: [NameTypePair] = []
    
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
                interactor.createTypeAndNotify(name: name.replacingOccurrences(of: " ", with: String()), fields: currentFields)
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
            
            currentFields.append(nameTypePair)
            let indexToAdd = IndexPath(row: dataSource.models.count, section: .zero)
            let typeRepresentation = TypeFormatter.representation(of: nameTypePair.type)
            dataSource.models.append(
                FieldViewModel(
                    name: nameTypePair.name,
                    type: typeRepresentation
                )
            )
            
            view.updateTableView(deletions: [], insertions: [indexToAdd], modifications: [])
        }
    }
}
