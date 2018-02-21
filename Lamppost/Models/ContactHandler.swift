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
    
    var contacts : [CNContact] = []
    
    init() {
        contactStore = CNContactStore()
    }
    
    /*
        if UserDefaults.standard.bool(forKey: "contact_permission_granted") {
            self.getContacts()
            completion(true)
        } else {
            contactStore.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                if granted {
                    self.getContacts()
                    completion(true)
                    UserDefaults.standard.set(true, forKey: "contact_permission_granted")
                }
            })
        }
 
 */
    
    func getFlyerCollection(fromData : [String], order : Int, collectionName: String) -> FlyerCollection {
        
        importContacts(withIdentifiers: fromData)
        
        var flyers : [Flyer] = []
        
        for contact in contacts {
            
            flyers.append(getFlyerFromContact(contact: contact))
            
        }
        
        return FlyerCollection(withName: collectionName, order: order, andFlyers: flyers)
        
    }
    
    func importContacts(withIdentifiers : [String] = []) {
        
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
        if withIdentifiers.isEmpty {
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
        } else {
            for identifier in withIdentifiers {
                do {
                    let contact = try contactStore.unifiedContact(withIdentifier: identifier, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                    results.append(contact)
                } catch {
                    print("Error fetching results for container")
                }
            }
        }
        contacts = results
    }
    
    
    func getFlyerFromContact(contact : CNContact) -> ContactFlyer {
        var details = ["first_name" : contact.givenName,
                       "middle_name" : contact.middleName,
                       "last_name" : contact.familyName,
                       "nickname" : contact.nickname,
                       "identifier" : contact.identifier
            ] as [String : Any]
        
        var numbers : [String : String] = [:]
        
        if contact.phoneNumbers.count > 0 {
            for number in contact.phoneNumbers {
                numbers[((number.label?.replacingOccurrences(of: "_$!<", with: "").replacingOccurrences(of: ">!$_", with: ""))?.replacingOccurrences(of: "FAX", with: " Fax"))!] = number.value.stringValue
            }
        }
        
        details["phone_numbers"] = numbers
        
        var emails : [String : String] = [:]
        
        if contact.emailAddresses.count > 0 {
            for email in contact.emailAddresses {
                emails[(email.label?.replacingOccurrences(of: "_$!<", with: "").replacingOccurrences(of: ">!$_", with: "").replacingOccurrences(of: "FAX", with: " Fax"))!] = (email.value as String) as String
            }
        }
        
        details["email_addresses"] = emails
        
        var image : UIImage
        
        if contact.imageDataAvailable {
            image = UIImage(data: contact.imageData!)!
        } else {
            image = UIImage(named: "logo-placeholder.png")!
        }
        
        var title = ""
        
        if details["nickname"] != nil && !(details["nickname"] as! String).isEmpty {
            title = details["nickname"] as! String
        } else if details["first_name"] != nil && !(details["first_name"] as! String).isEmpty {
            title = details["first_name"] as! String
            if details["last_name"] != nil {
                let lastName = details["last_name"] as! String
                if !lastName.isEmpty {
                    title += " \(lastName[(lastName.startIndex)])."
                }
            }
        } else if details["last_name"] != nil && !(details["last_name"] as! String).isEmpty {
            title = details["last_name"] as! String
        } else {
            title = "unknown contact"
        }
        
        
        return ContactFlyer(title: title, icon: image, details: details)
        
    }
    
    func generateFlyers() -> [FlyerCollection] {
        
        var result : [Character : FlyerCollection] = [:]
        
        
        
        for contact in contacts {
            
            let flyer = getFlyerFromContact(contact: contact)
        
            let title = flyer.title
            
            if result[title[title.startIndex]] != nil {
                result[title[title.startIndex]]?.addFlyer(flyer: flyer)
            } else {
                result[title[title.startIndex]] = FlyerCollection(withName: "\(title[title.startIndex])", order: 0, andFlyers: [flyer])
            }
            
        }
        
        return Array(result.values)
        
    }
    
}
