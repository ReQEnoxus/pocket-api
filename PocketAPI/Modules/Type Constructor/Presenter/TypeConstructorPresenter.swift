//
//  TypeConstructorPresenter.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity

final class TypeConstructorPresenter: TypeConstructorViewOutput {
    
    weak var view: TypeConstructorViewInput!
    var router: TypeConstructorRouterInput!
    var interactor: TypeConstructorInteractorInput!
    var customTypes: [String] = []
    
    func cancel() {
        router.dismiss()
    }
    
    func submit() {
        interactor.registerTypeAndNotify()
    }
    
    func reset() {
        interactor.setCurrentType(with: nil)
    }
    
    func loadTypes() {
        interactor.loadCustomTypes()
    }
    
    func didSelect(category: SectionCategory, index: Int) {
        switch category {
        case .primitive:
            guard let type = Primitive(rawValue: index) else { return }
            interactor.setCurrentType(with: .primitive(type: type))
        case .custom:
            interactor.setCurrentType(with: .custom(type: customTypes[index]))
        case .array:
            interactor.encloseCurrentTypeInArray()
        }
    }
    
    //MARK: - private methods
    func gatherPrimitives() -> [String] {
        return Primitive.allCases.map { primitive -> String in
            switch primitive {
            case .bool:
                return "Bool"
            case .number:
                return "Number"
            case .string:
                return "String"
            }
        }
    }
}

extension TypeConstructorPresenter: TypeConstructorInteractorOutput {
    func didFinishLoadingCustomTypes(types: [Type]) {
        let primitives = gatherPrimitives()
        customTypes = types.map { $0.name }
        
        
        let viewModel = AvailableTypesViewModel(
            sections: [
                TypeSection(category: .primitive, types: primitives.map { TypeCellViewModel(name: $0) }),
                TypeSection(category: .custom, types: customTypes.map { TypeCellViewModel(name: $0) }),
                TypeSection(category: .array, types: [TypeCellViewModel(name: "Array...")])
            ]
        )
        
        view.display(viewModel: viewModel)
    }
    
    func didFinishCreatingType() {
        router.dismiss()
    }
    
    func didFinishTask(with error: Error) {
        router.showErrorAlert(message: error.localizedDescription)
    }
    
    func didSetCurrentType(_ type: BasicType?) {
        if let type = type {
            view.display(type: TypeFormatter.representation(of: type))
        }
        else {
            view.reset()
        }
    }
}
