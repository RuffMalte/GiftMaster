//
//  AddGiftView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI

struct AddGiftView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @StateObject var person: Person
    
    @State private var newGiftTitle: String = ""
    @State private var newGiftPrice: String = ""
    @State private var newGiftStatus: String = ""
    
    let locale = Locale.current
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $newGiftTitle)
                    HStack {
                        TextField("Price", text: $newGiftPrice)
                           .keyboardType(.numberPad)
                           
                        Spacer()
                        let currencySymbol = locale.currencySymbol!
                        Text("\(currencySymbol)")
                    }
                   
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newGift = Gift(context: managedObjectContext)
                        newGift.title = newGiftTitle
                        newGiftPrice = newGiftPrice.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
                        newGift.price = Int16(newGiftPrice) ?? 0
                        newGift.status = giftStatusArray[0].title
                        newGift.id = UUID()
                        
                        person.addToGifts(newGift)
                        do { try self.managedObjectContext.save() }
                        catch { print(error) }
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationTitle("Add gift")
        }
            
    }
}

