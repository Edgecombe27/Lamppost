//
//  FlyerCollection.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/9/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation

class FlyerCollection {
    
    var name : String
    var collection : [Flyer]
    
    init(withName: String, andFlyers: [Flyer]) {
        name = withName
        collection = andFlyers
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
    
    subscript(index : Int) -> Flyer {
        get {
            return collection[index]
        } set {
            collection[index] = newValue
        }
    }
    
}
