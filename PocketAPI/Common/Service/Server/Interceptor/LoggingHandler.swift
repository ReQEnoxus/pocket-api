//
//  LoggingHandler.swift
//  PocketAPI
//
//  Created by Enoxus on 29.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Telegraph

class LoggingHandler: HTTPRequestHandler {
    
    func respond(to request: HTTPRequest, nextHandler: (HTTPRequest) throws -> HTTPResponse?) throws -> HTTPResponse? {
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: .didCatchRequest, object: .none, userInfo: [UserInfoKeys.requestInfo: RequestNotification(method: request.method.name, path: request.uri.path)])
        }
        
        return try nextHandler(request)
    }
}
