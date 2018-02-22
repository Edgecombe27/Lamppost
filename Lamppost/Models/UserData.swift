//
//  File.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/21/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation
import UIKit
class UserData {
    
    static let ORDER_DATA = "sdfghjki765rfghu765rghu765"
    static let FIRST_NAME = "first_name"
    static let LAST_NAME = "last_name"
    private static let USER_DATA_KEY = "user_data"
    private static let SORT_PREFERENCE_KEY = "sort_preference"

    
    static var numGroups = 0
    
    private var data : [String : Any]
    
    init() {
        
        if let savedData  = UserDefaults.standard.persistentDomain(forName: UserData.USER_DATA_KEY) {
            data = savedData
        } else {
            data = [:]
        }
        
        UserData.numGroups = data.count
        
    }
    
    func collectionExists(collectionName : String) -> Bool {
        return data[collectionName] != nil
    }
    
    func addCollection(collection : FlyerCollection) {
        
        data[collection.name] = []
        
        
        addFlyer(flyer: ContactFlyer(title: UserData.ORDER_DATA, icon: UIImage(), details: ["identifier" : "\(collection.order)"]), toCollection: collection)
        
        for flyer in collection.collection {
            addFlyer(flyer: flyer, toCollection: collection)
        }
        
        UserData.numGroups = UserData.numGroups + 1
        
    }
    
    func removeCollection(collection: FlyerCollection) {
        
        data.removeValue(forKey: collection.name)
        
        UserDefaults.standard.setPersistentDomain(data, forName: UserData.USER_DATA_KEY)
    }
    
    func addFlyer(flyer : Flyer, toCollection: FlyerCollection) {
        
        let contactFlyer = flyer as! ContactFlyer
        
        var collectionData : [String] = data[toCollection.name] as! [String]
        
        collectionData.append(contactFlyer.details["identifier"] as! String)
        
        data[toCollection.name] = collectionData
        
        UserDefaults.standard.setPersistentDomain(data, forName: UserData.USER_DATA_KEY)

        
    }
    
    func removeFlyer(flyer : Flyer, fromCollection : FlyerCollection) {
        
        let contactFlyer = flyer as! ContactFlyer
        let contactIdentifier = contactFlyer.details["identifier"] as! String
        
        var collection = data[fromCollection.name] as! [String]
        
        collection.remove(at: collection.index(of: contactIdentifier)!)
        
        data[fromCollection.name] = collection
        
        if collection.count == 1 {
            data.removeValue(forKey: fromCollection.name)
        }
        
        UserDefaults.standard.setPersistentDomain(data, forName: UserData.USER_DATA_KEY)
    }
    
    func fetchData() {
        data = UserDefaults.standard.persistentDomain(forName: UserData.USER_DATA_KEY)!
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
        
        result.sort { (c1, c2) -> Bool in
            return c1.order <= c2.order
        }
        
        return result
        
    }
    
    static func setSortPreference(preference : String) {
        UserDefaults.standard.set(preference, forKey: SORT_PREFERENCE_KEY)
    }
    
    static func getSortPrefernece() -> String {
        
        if let preference = UserDefaults.standard.object(forKey: SORT_PREFERENCE_KEY) {
            return preference as! String
        } else {
            return UserData.FIRST_NAME
        }
        
        
        
    }
    
    
    
}
