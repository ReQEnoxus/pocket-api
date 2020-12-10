//
//  ServerServiceImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 22.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Telegraph
import Entity

class ServerServiceImpl: ServerService {
    
    private static var sharedServer: ServerService?
    
    private init() {
        
    }
    
    static var shared: ServerService {
        
        if sharedServer != nil {
            return sharedServer!
        }
        else {
            
//            let storage = EntityStorageImpl()
            let encoder = BasicEntityEncoder()
            let decoder = BasicEntityDecoder()
            
            let service = ServerServiceImpl()
//            service.storage = storage
            service.encoder = encoder
            service.decoder = decoder
            
            sharedServer = service
            
            return service
        }
    }
    
    var state: ServerState = .down {
        didSet {
            NotificationCenter.default.post(name: .didChangeServerState, object: .none, userInfo: [UserInfoKeys.serverState: state])
        }
    }
    
    var server: Server!
    var storage: EntityStorage!
    var encoder: EntityEncoder!
    var decoder: EntityDecoder!
    
    func startServer(for types: [Type]) {
        
        switch state {
        case .up:
            return
        default:
            state = .startingUp
        }
        
        self.server = Server()
        
        guard let ip = IPUtil.deviceIp else {
            
            state = .error(description: "Failed to retrieve device ip")
            NSLog("failed to retrieve ip")
            return
        }
        
        do {
            try self.server.start(port: 1337)
        }
        catch (let error) {
            state = .error(description: error.localizedDescription)
            return
        }
        
        NSLog("started server on \(ip):\(server.port)")
        
        self.setupServer(types: types)
        
        state = .up(ip: ip, port: String(server.port))
        NSLog("endpoints set up")
    }
    
    func stopServer() {
        
        state = .down
        server.stop(immediately: true)
        NSLog("Server stopped")
    }
    
    private func setupServer(types: [Type]) {
        
        server.httpConfig.requestHandlers.insert(LoggingHandler(), at: .zero)
        
        for type in types {
            
            for requestType in SupportedRequests.allCases {
                
                switch requestType {
                    
                case .getAll:
                    
                    server.route(.GET, "/\(type.name.lowercased())") { [unowned self] request -> HTTPResponse? in
                        
                        let allInstances = self.storage.getAllInstances(of: type)
                        let responseData = self.encoder.encode(entities: allInstances)
                        
                        if let data = responseData {
                            return HTTPResponse(.ok, version: .default, headers: .empty, body: data)
                        }
                        else {
                            
                            let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "For some reason, service was unable to encode storage data")
                            return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                        }
                    }
                case .getById:
                    
                    server.route(.GET, regex: "/\(type.name.lowercased())/:id") { [unowned self] request -> HTTPResponse? in
                        
                        if let param = request.params["id"], let requestedId = Int(param) {
                            
                            let requestedEntity = self.storage.getInstance(of: type, by: requestedId)
                            
                            if let entity = requestedEntity, let encodedEntity = self.encoder.encode(entity: entity) {
                                return HTTPResponse(.ok, version: .default, headers: .empty, body: encodedEntity)
                            }
                            else {
                                
                                let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "Failed to find the entity by given id or failed to encode one")
                                return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                            }
                        }
                        else {
                            
                            let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "No id provided")
                            return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                        }
                    }
                case .addEntity:
                    
                    server.route(.POST, "/\(type.name.lowercased())") { [unowned self] request -> HTTPResponse? in
                        
                        let data = request.body
                        
                        if let decodedEntity = self.decoder.decode(from: data, of: type) {
                            
                            // force unwrapping because the entity was successfully decoded in the line above
                            return HTTPResponse(.ok, version: .default, headers: .empty, body: self.encoder.encode(entity: self.storage.saveInstance(decodedEntity))!)
                        }
                        else {
                            
                            let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "Entity was not created due to malformed request")
                            return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                        }
                    }
                case .deleteEntity:
                    
                    server.route(.DELETE, regex: "/\(type.name.lowercased())/:id") { [unowned self] request -> HTTPResponse? in
                        
                        if let param = request.params["id"], let requestedId = Int(param) {
                            
                            let requestedEntity = self.storage.getInstance(of: type, by: requestedId)
                            
                            if let entity = requestedEntity, let encodedEntity = self.encoder.encode(entity: entity) {
                                
                                self.storage.deleteInstance(of: type, by: requestedId)
                                return HTTPResponse(.ok, version: .default, headers: .empty, body: encodedEntity)
                            }
                            else {
                                
                                let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "Failed to find the entity by given id")
                                return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                            }
                        }
                        else {
                            
                            let response = ResponseEntity.asJson(status: HTTPStatus.badRequest.code, message: "No id provided")
                            return HTTPResponse(.badRequest, version: .default, headers: .empty, body: response)
                        }
                    }
                }
            }
        }
    }
}
