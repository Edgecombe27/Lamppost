//
//  File.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/21/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation

class UserData {
    
    private var data : [String : Any]
    
    init() {
        
        if let savedData  = UserDefaults.standard.persistentDomain(forName: "user_data") {
            data = savedData
        } else {
            data = [:]
        }
    }
    
    func collectionExists(collection : FlyerCollection) -> Bool {
        return data[collection.name] != nil
    }
    
    func addCollection(collection : FlyerCollection) {
        
        data[collection.name] = []
        
        for flyer in collection.collection {
            addFlyer(flyer: flyer, toCollection: collection)
        }
        
    }
    
    func removeCollection(named: String) {
        
        UserDefaults.standard.setPersistentDomain(data, forName: "user_data")
    }
    
    func addFlyer(flyer : Flyer, toCollection: FlyerCollection) {
        
        let contactFlyer = flyer as! ContactFlyer
        
        var collectionData : [String] = data[toCollection.name] as! [String]
        
        collectionData.append(contactFlyer.details["identifier"] as! String)
        
        data[toCollection.name] = collectionData
        
        UserDefaults.standard.setPersistentDomain(data, forName: "user_data")

        
    }
    
    func removeFlyer(flyer : Flyer, fromCollection : FlyerCollection) {
        
        UserDefaults.standard.setPersistentDomain(data, forName: "user_data")
    }
    
    func fetchData() {
        data = UserDefaults.standard.persistentDomain(forName: "user_data")!
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    func getFlyerData() -> [FlyerCollection] {
        
        let contactHandler = ContactHandler()
        
        var result : [FlyerCollection] = []
        
        for collection in data {
            result.append(contactHandler.getFlyerCollection(fromData: collection.value as! [String], order: 0, collectionName: collection.key))
        }
        
        return result
        
    }
    
    
    
}
