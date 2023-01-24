//
//  Person+CoreDataProperties.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//
//
import Foundation
import CoreData


extension Person {
         
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var color: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var gifts: NSSet?

    
    public var unwrappedName: String {
        return name ?? ""
    }
    
    public var unwrappedBirthday: Date {
        return birthday ?? Date.now
    }
    
    public var unwrappedIcon: String {
        return icon ?? "person"
    }
    
    public var giftArray: [Gift] {
        let set = gifts as? Set<Gift> ?? []
        
        return set.sorted {
            $0.unwrappedTitle < $1.unwrappedTitle
        }
    }
}

// MARK: Generated accessors for gifts
extension Person {

    @objc(addGiftsObject:)
    @NSManaged public func addToGifts(_ value: Gift)

    @objc(removeGiftsObject:)
    @NSManaged public func removeFromGifts(_ value: Gift)

    @objc(addGifts:)
    @NSManaged public func addToGifts(_ values: NSSet)

    @objc(removeGifts:)
    @NSManaged public func removeFromGifts(_ values: NSSet)

}

extension Person : Identifiable {

}
