//
//  TypeConstructorRouter.swift
//  PocketAPI
//
//  Created by Enoxus on 10.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

final class TypeConstructorRouter: TypeConstructorRouterInput {
    weak var view: UIViewController?
    
    func dismiss() {
        view?.dismiss(animated: true)
    }
}
