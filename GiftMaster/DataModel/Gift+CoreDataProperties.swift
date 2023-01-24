//
//  Gift+CoreDataProperties.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//
//

import Foundation
import CoreData


extension Gift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gift> {
        return NSFetchRequest<Gift>(entityName: "Gift")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var price: Int16
    @NSManaged public var status: String?
    @NSManaged public var person: Person?
    
    public var unwrappedStatus: String {
        return status ?? giftStatusArray[0].title
    }
    
    public var unwrappedTitle: String {
        return title ?? "Unkown Title"
    }
    
    public var unwrappedPrice: Int16 {
        return price
    }
}

extension Gift : Identifiable {

}
