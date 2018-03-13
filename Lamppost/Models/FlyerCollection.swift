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
        
        var i = 0
        
        while i < collection.count-1 {
            let f1 = collection[i] as! ContactFlyer
            let f2 = collection[i+1] as! ContactFlyer
            if (f1.details["first_name"] as! String) == (f2.details["first_name"] as! String) && (f1.details["last_name"] as! String) == (f2.details["last_name"] as! String) && (f1.details["phone_numbers"] as! [String:String]) == (f2.details["phone_numbers"] as! [String:String]) {
                self.removeFlyer(atIndex: i+1)
            } else {
                i = i + 1
            }
            
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
