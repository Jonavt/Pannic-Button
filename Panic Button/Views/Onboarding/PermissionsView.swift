//
//  ContactsPermission.swift
//  Panic Button
//
//  Created by UDLAP18 on 09/03/23.
//

import SwiftUI
import CoreLocation

struct PermissionsView: View {
    @Environment(\.dismiss) var dismiss
    @State var showContacts = false
    @EnvironmentObject var locVM: LocationViewModel
    @EnvironmentObject var conVM: ContactsViewModel

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
                .disabled((locVM.authorizationStatus == .authorizedAlways || locVM.authorizationStatus == .authorizedWhenInUse) && conVM.hasAccess ? false : true)
                .opacity((locVM.authorizationStatus == .authorizedAlways || locVM.authorizationStatus == .authorizedWhenInUse) && conVM.hasAccess ? 1 : 0.5)
            }
            .padding(.horizontal, 0)
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
                    conVM.requestAccess()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        Image(systemName: "person")
                            .padding(.trailing, 5)

                        Text("Dar permiso a contactos")
            
                        Spacer(minLength: 0)
                        
                        if conVM.hasAccess {
                            Image(systemName: "checkmark.circle.fill")
                                .padding(.horizontal, 5)
                        }

                    }
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.blue)
                .allowsHitTesting(!conVM.hasAccess)
                .opacity(conVM.hasAccess ? 0.5 : 1)
                
                Button {
                    locVM.requestPermission()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        Image(systemName: "mappin.and.ellipse")
                            .padding(.trailing, 5)
                        
                        Text("Dar permiso a ubicacion")
                        
                        Spacer(minLength: 0)
                        
                        if locVM.authorizationStatus == .authorizedAlways || locVM.authorizationStatus == .authorizedWhenInUse {
                            Image(systemName: "checkmark.circle.fill")
                                .padding(.horizontal, 5)
                        }
                    }
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.blue)
                .allowsHitTesting(locVM.authorizationStatus == .authorizedAlways || locVM.authorizationStatus == .authorizedWhenInUse ? false : true)
                .opacity(locVM.authorizationStatus == .authorizedAlways || locVM.authorizationStatus == .authorizedWhenInUse ? 0.5 : 1)
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
            .environmentObject(LocationViewModel())
            .environmentObject(ContactsViewModel())
    }
}
