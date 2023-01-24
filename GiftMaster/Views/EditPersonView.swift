//
//  EditPersonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI

struct EditPersonView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var person: Person
    @State private var name: String = ""
    @State private var birthday: Date = Date()
    @State private var color: Color = getColorFromString(s: PersonRowColorArray[0].colorString)
    @State private var icon: PersonIcon = PersonIconsArray[0]
    

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    TextField("Name", text: $name)
                    Menu {
                        ForEach(PersonIconsArray) { item in
                            Button {
                                icon = item
                            } label: {
                                Label(item.description, systemImage: item.icon)
                            }
                        }
                    } label: {
                        Image(systemName: icon.icon)
                    }
                }
                
                DatePicker("Birthday", selection: $birthday)
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(alignment: .center, spacing: 2) {
                        ForEach(PersonRowColorArray) { item in
                            Image(systemName: color == item.color ? "checkmark.circle.fill" : "circle.fill")
                                .foregroundColor(item.color)
                                .clipShape(Circle())
                                .font(.largeTitle)
                                .onTapGesture {
                                    color = item.color
                                }
                                
                                
                        }
                    }
                }
            }.onAppear {
                name = person.unwrappedName
                birthday = person.unwrappedBirthday
                color = getColorFromString(s: person.color ?? "red")
                icon.icon = person.unwrappedIcon
            }
            .navigationTitle("Edit " + person.unwrappedName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // update person in Core Data
                        person.name = name
                        person.birthday = birthday
                        person.color = getStringFromColor(c: color)
                        person.icon = icon.icon
                        do { try self.managedObjectContext.save() }
                        catch { print(error) }
                        dismiss()
                    } label: {
                        Text("Save Changes")
                    }
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
