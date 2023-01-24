//
//  GiftListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI

struct GiftsListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var person: Person
            
    @State private var isShowingDeletePersonDialog: Bool = false
    @State private var isShowingDeleteGiftDialog: Bool = false
    @State private var isShowingEditView: Bool = false
    @State private var isShowingAddGiftView: Bool = false
    @State private var isShowingEditGiftView: Bool = false
    
    @State private var giftToDelete: Gift = Gift()
    @State private var giftToEdit: Gift = Gift()
    
    var body: some View {
        Form {
            Section {
                addGiftButton()
                ForEach(person.giftArray) { gift in
                    GiftListRowView(gift: gift)
                        
                    
                    //delte and Edit swipe Action
                    .swipeActions(edge: .trailing) { swipeActionDeleteGift(gift: gift) }
                    .swipeActions(edge: .trailing) { swipeActionEditGift(gift: gift) }
                }
            }
        }
        
        .sheet(isPresented: $isShowingAddGiftView) {
            AddGiftView(person: person)
                .presentationDetents([.medium, .fraction(0.75)])
        }
        .sheet(isPresented: $isShowingEditGiftView) {
            GiftEditView(gift: $giftToEdit)
                .presentationDetents([.medium, .fraction(0.75)])
        }
        .sheet(isPresented: $isShowingEditView) {
            AddEditPersonView(isEditMode: true, person: $person)
            .presentationDetents([.medium, .fraction(0.75)])
        }
        .toolbar {
            showEditPersonToolbarItem()
            showDeletePersonToolbarItem()
        }
        .confirmationDialog (
            "Are you sure?",
            isPresented: $isShowingDeleteGiftDialog,
            titleVisibility: .visible) {
                Button(role: .destructive) {
                    person.removeFromGifts(giftToDelete)
                    do { try self.managedObjectContext.save() }
                    catch { print(error) }
                } label: {
                    Text("Delete")
                }
        }
        
        .confirmationDialog (
            "Are you sure?",
            isPresented: $isShowingDeletePersonDialog,
            titleVisibility: .visible) {
                Button(role: .destructive) {
                    managedObjectContext.delete(person)
                    do { try self.managedObjectContext.save() }
                    catch { print(error) }
                } label: {
                    Text("Delete")
                }
        }
        .navigationTitle(person.unwrappedName)
    }
    
    fileprivate func showEditPersonToolbarItem() -> ToolbarItem<(), Button<Image>> {
        return ToolbarItem(placement: .primaryAction) {
            Button {
                self.isShowingEditView = true
            } label: {
                Image(systemName: "applepencil")
            }
        }
    }
    
    fileprivate func showDeletePersonToolbarItem() -> ToolbarItem<(), Button<Image>> {
        return ToolbarItem(placement: .primaryAction) {
            Button(role: .destructive) {
                isShowingDeletePersonDialog = true
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    
    fileprivate func swipeActionDeleteGift(gift: Gift) -> Button<Image> {
        return Button(role: .destructive) {
            giftToDelete = gift
            isShowingDeleteGiftDialog = true
        } label: {
            Image(systemName: "trash")
        }
    }
    
    fileprivate func swipeActionEditGift(gift: Gift) -> some View {
        return Button {
            giftToEdit = gift
            isShowingEditGiftView = true
        } label: {
            Image(systemName: "applepencil")
        }
        .tint(.yellow)
    }
    
    fileprivate func addGiftButton() -> Button<HStack<TupleView<(Image, Text)>>> {
        return Button {
            isShowingAddGiftView = true
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "plus")
                Text("Add a new Gift")
            }
        }
    }
}

