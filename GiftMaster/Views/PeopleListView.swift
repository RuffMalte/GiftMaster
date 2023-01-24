//
//  PeopleListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI
import CoreData

struct PeopleListView: View {
    @FetchRequest(sortDescriptors: []) var people: FetchedResults<Person>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var isShowingAddPersonView: Bool = false
    @State private var isShowingDeleteDonfirmationDialog: Bool = false
    @State private var isShowingEditPersonView: Bool = false
    
    @State var personToDelete: Person = Person()
    @State var personToEdit: Person = Person()
    @State var person23 = Person()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    
    var body: some View {
        NavigationView {
            Section {
                Form {
                    ForEach(people) { person in
                        NavigationLink(destination: GiftsListView(person: person)) {
                            HStack{
                                Image(systemName: person.unwrappedIcon)
                                
                                VStack(alignment: .leading) {
                                    Text(person.unwrappedName)
                                        .font(.headline)
                                        .foregroundColor(getColorFromString(s: person.color ?? "red"))
                                    Text(dateFormatter.string(from: person.unwrappedBirthday))
                                        .font(.subheadline)
                                }
                            }
                            
                            
                            .swipeActions(allowsFullSwipe: true) {
                                Button(role: .none) {
                                    isShowingDeleteDonfirmationDialog = true
                                    personToDelete = person
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    isShowingEditPersonView = true
                                    personToEdit = person
                                    
                                } label: {
                                    Image(systemName: "applepencil")
                                }
                                .tint(.yellow)

                            }
                        }
                        
                    }
                }
            }
            
            

            .navigationBarTitle("People")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                   
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddPersonView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .confirmationDialog(
                LocalizedStringKey("Are you sure?"),
                isPresented: $isShowingDeleteDonfirmationDialog,
                titleVisibility: .visible,
                actions: {
                    Button(role: .destructive) {
                        isShowingDeleteDonfirmationDialog = false
                        managedObjectContext.delete(personToDelete)
                        do { try self.managedObjectContext.save() }
                        catch { print(error) }
                    } label: {
                        Text("Delete")
                    }
                    

            })
            .sheet(isPresented: $isShowingEditPersonView) {
                AddEditPersonView(isEditMode: true, person: $personToEdit)
                    .presentationDetents([.medium, .fraction(0.75)])
            }
            .sheet(isPresented: $isShowingAddPersonView) {
                AddEditPersonView(isEditMode: false, person: $person23)
                    .presentationDetents([.medium, .fraction(0.75)])
            }
        }
    }
}
    
