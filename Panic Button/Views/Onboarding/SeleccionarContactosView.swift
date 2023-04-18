//
//  SeleccionarContactosView.swift
//  Panic Button
//
//  Created by UDLAP14 on 09/03/23.
//

import SwiftUI
import CoreData

struct SeleccionarContactosView: View {
    @State private var searchText: String = ""
    @FocusState private var messageIsFocused: Bool

    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @EnvironmentObject var conVM: ContactsViewModel
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var savedContacts: FetchedResults<Contact>
    var isChanging: Bool
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Contacto de emergencia")
                    .font(.largeTitle.weight(.heavy))
                
                Text("Selecciona tu contacto de emergencia")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                CustomField(searchText: $searchText, image: "magnifyingglass", text: "Busca tus contactos")
                    //.padding(.horizontal)
                    .focused($messageIsFocused)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach (conVM.contacts.filter({ (cont) -> Bool in
                            self.searchText.isEmpty ? true :
                            "\(cont)".lowercased().contains(self.searchText.lowercased())
                        })) { contact in
                            Button {
//                                if !savedContacts.contains(where: { contact.phoneNumber?.stringValue == $0.phoneNumber}) {
//                                    let newContact = Contact(context: moc)
//                                    newContact.firstName = contact.firstName
//                                    newContact.lastName = contact.lastName
//                                    newContact.phoneNumber = contact.phoneNumber?.stringValue
//                                    try? moc.save()
//                                } else {
//                                    if let oldContact = savedContacts.first(where: { $0.phoneNumber == contact.phoneNumber?.stringValue}) {
//                                        moc.delete(oldContact)
//                                    }
//                                }
                                if savedContacts.count == 0 {
                                    let newContact = Contact(context: moc)
                                    newContact.firstName = contact.firstName
                                    newContact.lastName = contact.lastName
                                    newContact.phoneNumber = contact.phoneNumber?.stringValue
                                    try? moc.save()
                                } else {
                                    if let oldContact = savedContacts.first(where: { $0.phoneNumber == contact.phoneNumber?.stringValue}) {
                                        moc.delete(oldContact)
                                    }
                                }
                            } label: {
                                ContactRow(contact: contact)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                    .padding(.top, 10)

                }
                .onTapGesture {
                    messageIsFocused = false
                }

//                Spacer()
                
                Button {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 3)) {
                        hasCompletedOnboarding = true
                    }
                    
                    if isChanging {
                        
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Entrar")
                        Spacer()
                    }
                }
                .padding()
                .font(.title3)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(15)
                .allowsHitTesting(savedContacts.count == 1 ? true : false)
                .opacity(savedContacts.count == 1 ? 1 : 0.5)
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar(.hidden, for: .navigationBar)
        .onTapGesture {
            messageIsFocused = false
        }
        .onAppear {
            conVM.contacts = conVM.fetchingContacts()
        }
    }
}

struct SeleccionarContactosView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionarContactosView(isChanging: true)
            .environmentObject(LocationViewModel())
            .environmentObject(ContactsViewModel())
    }
}



