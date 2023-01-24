//
//  AddEditPersonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 09.12.22.
//

import SwiftUI

struct AddEditPersonView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var birthday: Date = Date()
    @State private var personColor: PersonRowColor = PersonRowColorArray[0]
    @State private var icon: PersonIcon = PersonIconsArray[0]
    
    @State var isEditMode: Bool
    @Binding var person: Person
        
    var body: some View {
        NavigationView {
            Form {
                
                //name and Icon
                HStack{
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
                
                //Birthday selection
                DatePicker(
                    "Birthday",
                    selection: $birthday,
                    displayedComponents: .date)
                    .datePickerStyle(.compact)
                
                //Color Choice
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(alignment: .center, spacing: 2) {
                        ForEach(PersonRowColorArray) { item in
                            Image(systemName: personColor.colorString == item.colorString ? "checkmark.circle.fill" : "circle.fill")
                                .foregroundColor(item.color)
                                .clipShape(Circle())
                                .font(.largeTitle)
                                .onTapGesture {
                                    personColor = item
                                }
                        }
                    }
                }
            }
            .onAppear {
                if (isEditMode) {
                    name = person.unwrappedName
                    birthday = person.unwrappedBirthday
                    personColor.colorString = person.color!
                    icon.icon = person.icon ?? "person"
                   
                }
            }
            .navigationTitle(isEditMode ? "Edit Person": "Add Person")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (!isEditMode) {
                            let newPerson = Person(context: moc)
                            newPerson.name = name
                            newPerson.id = UUID()
                            newPerson.birthday = birthday
                            newPerson.icon = icon.icon
                            newPerson.color = personColor.colorString
                        } else {
                            person.name = name
                            person.birthday = birthday
                            person.color = personColor.colorString
                            person.icon = icon.icon
                        }
                        
                        do { try moc.save() }
                        catch { print(error) }
                        
                        dismiss()
                    } label: {
                        Text("Save")
                    }.disabled(name.isEmpty)
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
