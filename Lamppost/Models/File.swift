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
        self.data = UserDefaults.standard.volatileDomain(forName: "user_data")
    }
    
    func addCollection(collection : FlyerCollection) {
        
        UserDefaults.standard.setVolatileDomain(data, forName: "user_data")
    }
    
    func removeCollection(named: String) {
        
        UserDefaults.standard.setVolatileDomain(data, forName: "user_data")
    }
    
    func addFlyer(flyer : Flyer, toCollection: FlyerCollection) {
        
        UserDefaults.standard.setVolatileDomain(data, forName: "user_data")
    }
    
    func removeFlyer(flyer : Flyer, fromCollection : FlyerCollection) {
        
        UserDefaults.standard.setVolatileDomain(data, forName: "user_data")
    }
    
    func fetchData() {
        data = UserDefaults.standard.volatileDomain(forName: "user_data")
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    
    
}
