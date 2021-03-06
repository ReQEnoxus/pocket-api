//
//  FieldCreatorPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Entity

class FieldCreatorPresenter: FieldCreatorViewOutput {
    
    var router: FieldCreatorRouterInput!
    var interactor: FieldCreatorInteractorInput!
    var currentType: BasicType?
    
    weak var view: FieldCreatorViewInput!
    
    var usedNames: [String]!
    
    func didPressedCancel() {
        router.dismiss()
    }
    
    func didPressedCreate(name: String?) {
        
        guard let name = name, !name.isEmpty else {
            
            router.showErrorAlert(message: "Please, specify a name for the field")
            return
        }
        if usedNames.contains(name) {
            router.showErrorAlert(message: "Please, use unique name for the field")
        }
        else {
            
            guard let type = currentType else {
                router.showErrorAlert(message: "Please, specify type for the field")
                return
            }
            
            let field = NameTypePair(name: name
                                            .replacingOccurrences(of: " ", with: String())
                                            .replacingOccurrences(of: ".", with: String()),
                                     type: type)
            interactor.createFieldAndNotify(field)
            router.dismiss()
        }
    }
    
    func didPressedSelectType() {
        router.showTypeConstructor(with: currentType)
    }
    
    func viewDidLoad() {
        interactor.startObservingNewBasicTypeNotifications()
    }
}

extension FieldCreatorPresenter: FieldCreatorInteractorOutput {
    func didCreateNewType(type: BasicType) {
        currentType = type
        view.displayCurrentTypeName(with: TypeFormatter.representation(of: type))
    }
}
