//
//  DataController.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Failed to load data: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
        
    }
}
