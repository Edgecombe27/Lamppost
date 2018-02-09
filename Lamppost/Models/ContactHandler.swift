//
//  ContactHandler.swift
//  Lamppost
//
//  Created by Spencer Edgecombe on 2/9/18.
//  Copyright © 2018 Lamppost. All rights reserved.
//

import Foundation
import Contacts
import UIKit

class ContactHandler {
    
    var contactStore : CNContactStore!
    
    var contacts : [CNContact]!
    
    init() {
        
    }
    
    func importContacts() {
        contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactImageDataKey] as [Any]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        contacts = results
    }
    
    func generateFlyers() -> [FlyerCollection] {
        
        var result : [Character : FlyerCollection] = [:]
        
        for contact in contacts {
            
            var details = ["first_name" : contact.givenName,
                           "middle_name" : contact.middleName,
                           "last_name" : contact.familyName,
                           "nickname" : contact.nickname,
                ] as [String : Any]
            
            var numbers : [String : String] = [:]
            
            if contact.phoneNumbers.count > 0 {
                for number in contact.phoneNumbers {
                    numbers[number.label!] = number.value.stringValue
                }
            }
            
            details["phone_numbers"] = numbers
            
            var emails : [String : String] = [:]
            
            if contact.emailAddresses.count > 0 {
                for email in contact.emailAddresses {
                    emails[email.label!] = email.value as String
                }
            }
            
            details["email_addresses"] = emails
            
            var image : UIImage
            
            if contact.imageDataAvailable {
                image = UIImage(data: contact.imageData!)!
            } else {
                image = UIImage(named: "icons8-basketball-100.png")!
            }
            
            var title = ""
            
            if (details["nickname"] != nil && !(details["nickname"] as! String).isEmpty) {title = details["nickname"] as! String}
            else if (details["first_name"] != nil) {title = "\(details["first_name"] as! String) \(details["last_name"] as! String)"}
            
            if result[title[title.startIndex]] != nil {
                result[title[title.startIndex]]?.addFlyer(flyer: ContactFlyer(title: title, icon: image, details: details))
            } else {
                result[title[title.startIndex]] = FlyerCollection(withName: "\(title[title.startIndex])", andFlyers: [ContactFlyer(title: title, icon: image, details: details)])
            }
            
        }
        
        return Array(result.values)
        
    }
    
}
