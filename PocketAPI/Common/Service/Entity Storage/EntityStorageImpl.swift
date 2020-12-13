//
//  EntityStorageImpl.swift
//  PocketAPI
//
//  Created by Enoxus on 12.12.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Entity
import SQLite

final class EntityStorageImpl: EntityStorage {
    
    private let db: Connection?
    private let tableName = "Entities"
    private let encoder: EntityEncoder
    private let decoder: EntityDecoder
    private var table: Table { Table(tableName) }
    
    init(
        encoder: EntityEncoder = BasicEntityEncoder(),
        decoder: EntityDecoder = BasicEntityDecoder(typeManager: TypeManagerWrapper.shared)
    ) {
        self.encoder = encoder
        self.decoder = decoder
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        db = try? Connection("\(path)/db.sqlite3")
        
        createMainTable()
    }
    
    
    func getAllInstances(of type: Type) -> [Entity] {
        guard let query = try? db?.prepare(table.filter(Expression<String>("type_name") == type.name)) else { return [] }
        return query.compactMap { row in
            let blob = row[Expression<Blob>("content")]
            let data = Data.fromDatatypeValue(blob)
            var entity = decoder.decode(from: data, of: type)
            entity?.fields["id"] = row[Expression<Int64>("id")]
            return entity
        }
    }
    
    func getInstance(of type: Type, by id: Int) -> Entity? {
        guard let query = try? db?.prepare(table.filter(Expression<String>("type_name") == type.name && Expression<Int64>("id") == Int64(id)).limit(1)) else { return nil }
        return query.compactMap { row in
            let blob = row[Expression<Blob>("content")]
            let data = Data.fromDatatypeValue(blob)
            var entity = decoder.decode(from: data, of: type)
            entity?.fields["id"] = row[Expression<Int64>("id")]
            return entity
        }.first
    }
    
    func saveInstance(_ instance: Entity) -> Entity {
        guard let encoded = encoder.encode(entity: instance)?.datatypeValue else { fatalError() }
        let type = Expression<String>("type_name")
        let content = Expression<Blob>("content")
        _ = try? db?.run(table.insert(type <- instance.type.name, content <- encoded))
        
        return instance
    }
    
    func deleteInstance(of type: Type, by id: Int) {
        let query = table.filter(Expression<String>("type_name") == type.name && Expression<Int64>("id") == Int64(id)).limit(1)
        _ = try? db?.run(query.delete())
    }
    
    func deleteAllInstances(of type: Type) {
        let query = table.filter(Expression<String>("type_name") == type.name)
        _ = try? db?.run(query.delete())
    }
    
    //MARK: - SQLite stack
    private func createMainTable() {
        let table = Table(tableName)
        _ = try? db?.run(table.create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"), primaryKey: .autoincrement)
            t.column(Expression<String>("type_name"))
            t.column(Expression<Blob>("content"))
        })
    }
}
