//
//  GiftStatus.swift
//  GiftMaster
//
//  Created by Malte Ruff on 23.12.22.
//

import Foundation
import SwiftUI

struct giftStatus: Identifiable, Hashable {
    var title: String
    var icon: String
    var Color: Color
    var id: UUID = UUID()
}

var giftStatusArray: [giftStatus] = [
    giftStatus(title: "Idea", icon: "lightbulb", Color: .yellow),
    giftStatus(title: "Bought", icon: "bag", Color: .purple),
    giftStatus(title: "Given", icon: "person.fill.checkmark", Color: .green)
]
