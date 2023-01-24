//
//  PersonRowIcon.swift
//  GiftMaster
//
//  Created by Malte Ruff on 16.12.22.
//

import Foundation
import SwiftUI

struct PersonIcon: Identifiable {
    var icon: String
    var description: String
    var id: UUID = UUID()
}

var PersonIconsArray: [PersonIcon] = [
    PersonIcon(icon: "person.fill", description: "Friend"),
    PersonIcon(icon: "person.3.fill", description: "Group"),
    PersonIcon(icon: "tortoise.fill", description: "Animal"),
    PersonIcon(icon: "heart.fill", description: "Loved One"),
    PersonIcon(icon: "globe.europe.africa.fill", description: "Internet Friend")
    ]
