//
//  GiftEditView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 10.12.22.
//

import SwiftUI

struct GiftEditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var gift: Gift
    @State private var title: String = ""
    @State private var price: String = ""
    
    let locale = Locale.current
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    HStack {
                        TextField("Price", text: $price)
                            .keyboardType(.numberPad)
                            .onSubmit {
                                let price = price.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted)
                            }
                        Spacer()
                        

                        let currencySymbol = locale.currencySymbol!
                        
                        Text("\(currencySymbol)")
                    }
                }
            }
            .onAppear {
                title = gift.unwrappedTitle
                price = String(gift.unwrappedPrice)
            }
            .navigationTitle("Edit " + gift.unwrappedTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // update person in Core Data
                        gift.title = title
                        gift.price = Int16(price) ?? 0
                        do { try self.managedObjectContext.save() }
                        catch { print(error) }
                        dismiss()
                    } label: {
                        Text("Save Changes")
                    }.disabled(gift.title == title && gift.price == Int16(price))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
        }
    }
}

