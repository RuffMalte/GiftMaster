//
//  GiftMasterApp.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI

@main
struct GiftMasterApp: App {
    
    @StateObject private var dataController = DataController()

    
    var body: some Scene {
        WindowGroup {
            PeopleListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
