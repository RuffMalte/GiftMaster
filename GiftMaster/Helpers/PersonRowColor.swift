//
//  PersonRowColor.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.12.22.
//

import Foundation
import SwiftUI

struct PersonRowColor: Identifiable, Equatable {
    var id: UUID = UUID()
    var color: Color
    var colorString: String
}

var PersonRowColorArray: [PersonRowColor] = [
    PersonRowColor(color: .red, colorString: "red"),
    PersonRowColor(color: .blue, colorString: "blue"),
    PersonRowColor(color: .green, colorString: "green"),
    PersonRowColor(color: .yellow, colorString: "yellow"),
    PersonRowColor(color: .brown, colorString: "brown"),
    PersonRowColor(color: .orange, colorString: "orange"),
    PersonRowColor(color: .teal, colorString: "teal"),
    PersonRowColor(color: .purple, colorString: "purple"),
    PersonRowColor(color: .pink, colorString: "pink")
]

func getStringFromColor(c: Color) -> String {
    var s: String = ""
    
    for item in PersonRowColorArray {
        if (c == item.color) {
            s = item.colorString
        }
    }
    return s
}

func getColorFromString(s: String) -> Color {
    var c: Color = .clear
    
    for item in PersonRowColorArray {
        if (s == item.colorString) {
            c = item.color
        }
    }
    return c
}

