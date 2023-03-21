//
//  ContactsPermission.swift
//  Panic Button
//
//  Created by UDLAP18 on 09/03/23.
//

import SwiftUI

struct PermissionsView: View {
    @Environment(\.dismiss) var dismiss
    @State var showContacts = false
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            
            HStack(alignment: .center, spacing: 15) {
                Button {
                    dismiss()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        
                        Image(systemName: "chevron.left")
                        Text("Atrás")
            
                    }
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Button {
                    showContacts = true
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                                   
                        Text("Siguiente")
                        Image(systemName: "chevron.right")

                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, -15)
            
            Text("Permite acceso")
                .font(.largeTitle.weight(.bold))
                .padding(.top,50)
                .multilineTextAlignment(.center)
            
            
            Spacer()
            
            Image("accessContacts")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Text("Antes de avanzar, \nnecesitamos algunos permisos")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 15) {
                Button {
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        Image(systemName: "person")
                            .padding(.trailing, 5)

                        Text("Dar permiso a contactos")
            
                        Spacer(minLength: 0)
                    }
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.blue)

                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        Image(systemName: "mappin.and.ellipse")
                            .padding(.trailing, 5)
                        
                        Text("Dar permiso a ubicacion")
                        
                        Spacer(minLength: 0)
                    }
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.blue)

            }
            .padding(.horizontal)
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $showContacts) {
            SeleccionarContactosView()
        }
    }
}

    
struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}
