//
//  User+CoreDataProperties.swift
//  
//
//  Created by Oswaldo Morales on 2/2/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user: String?
    @NSManaged public var name: String?
    @NSManaged public var secondname: String?
    @NSManaged public var birthdate: String?
    @NSManaged public var bio: String?
    @NSManaged public var password: String?
    @NSManaged public var avatar: Data?

}
