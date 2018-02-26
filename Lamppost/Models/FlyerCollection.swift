//
//  FlyerCollection.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/9/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation

class FlyerCollection {
    
    static let COLLECTION_TYPES = ["Contact", "Contact Group"]
    
    var name : String
    var order : Int
    var collection : [Flyer]
    var isGroup = false
    
    init(withName: String,order : Int, andFlyers: [Flyer]) {
        name = withName
        collection = andFlyers
        self.order = order
    }
    
    func addFlyer(flyer : Flyer) {
        collection.append(flyer)
    }
    
    func addFlyer(flyer : Flyer, atIndex: Int) {
        collection.insert(flyer, at: atIndex)
    }
    
    func removeFlyer(atIndex : Int) -> Flyer {
        return collection.remove(at: atIndex)
    }
    
    func count() -> Int {
        return collection.count
    }
    
    func sort() {
        collection.sort { (c1, c2) -> Bool in
            return c1.title.compare(c2.title) == .orderedAscending
        }
    }
    
    subscript(index : Int) -> Flyer {
        get {
            return collection[index]
        } set {
            collection[index] = newValue
        }
    }
    
}
