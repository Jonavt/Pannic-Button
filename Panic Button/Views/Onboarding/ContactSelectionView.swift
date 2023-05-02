//
//  SeleccionarContactosView.swift
//  Panic Button
//
//  Created by UDLAP14 on 09/03/23.
//

import SwiftUI
import CoreData

struct ContactSelectionView: View {
    @State private var searchText: String = ""
    @FocusState private var messageIsFocused: Bool

    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @EnvironmentObject var conVM: ContactsViewModel
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var savedContacts: FetchedResults<Contact>
    var isChanging: Bool
    @Environment(\.dismiss) var dismiss
    
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
                                if savedContacts.count == 0 {
                                    let newContact = Contact(context: moc)
                                    newContact.firstName = contact.firstName
                                    newContact.lastName = contact.lastName
                                    newContact.phoneNumber = contact.phoneNumber?.stringValue
                                    try? moc.save()
                                    buttonVibration()
                                } else {
                                    if let oldContact = savedContacts.first {
                                        moc.delete(oldContact)
                                    }
                                    
                                    let newContact = Contact(context: moc)
                                    newContact.firstName = contact.firstName
                                    newContact.lastName = contact.lastName
                                    newContact.phoneNumber = contact.phoneNumber?.stringValue
                                    try? moc.save()
                                    buttonVibration()
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

                
                Button {
                    buttonVibration()
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 3)) {
                        hasCompletedOnboarding = true
                    }
                    
                    if isChanging {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text(isChanging ? "Aceptar" : "Entrar")
                        Spacer()
                    }
                }
                .padding()
                .font(.title3.bold())
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(15)
                .allowsHitTesting(savedContacts.count == 1 ? true : false)
                .opacity(savedContacts.count == 1 ? 1 : 0.5)
                .accessibilityLabel(Text(isChanging ? "Aceptar" : "Entrar"))
                .accessibilityHint(Text(isChanging ? "Da acceso a la aplicación" : "Guarda tu nuevo contacto de emergencia"))

            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color("Background1"))
        .toolbar(.hidden, for: .navigationBar)
        .onTapGesture {
            messageIsFocused = false
        }
        .onAppear {
            conVM.contacts = conVM.fetchingContacts()
        }
    }
}

struct ContactSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactSelectionView(isChanging: true)
            .environmentObject(LocationViewModel())
            .environmentObject(ContactsViewModel())
    }
}



