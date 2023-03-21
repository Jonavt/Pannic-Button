//
//  ContactsPermission.swift
//  Panic Button
//
//  Created by UDLAP18 on 09/03/23.
//

import SwiftUI

struct ContactsPermission: View {
    var body: some View {
        VStack(alignment:.center, spacing: 25) {
            
            Text("Permite acceso a tus contactos")
                .font(.largeTitle.weight(.bold))
                .padding(.top,50)
                .multilineTextAlignment(.center)
            
            
            Spacer()
            
            Image("accessContacts")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Text("Necesitamos acceso a tus contactos\n para poder enviar los mensajes")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("Dar permiso")
                    Spacer()
                }
            }
            .padding()
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.blue.opacity(0.9))
            .cornerRadius(15)
            .padding()
            
            
            
        }
    }
}

    
struct ContactsPermission_Previews: PreviewProvider {
    static var previews: some View {
        ContactsPermission()
    }
}
