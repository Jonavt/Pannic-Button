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
            
                Text("Acceso a tus contactos")
                    .font(.largeTitle.weight(.bold))
                    .padding(.top,50)
                    
                    
            Spacer()
                
            Image("accessContacts")
                .resizable()
                .scaledToFit()
                //.frame(width: 200, height: 200)
            
            Spacer()
            
            Text("Necesitamos acceso a tus contactos\n para poder enviar los mensajes")
                .font(.headline).bold().italic()
                
            Spacer()
            
            Button("Dar Permiso") {
                        // Action code here
                    }
                    .padding(24)
                    .font(.system(.title, design: .default))
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(10)
            Spacer()
            
           
        }
    }
}

    
struct ContactsPermission_Previews: PreviewProvider {
    static var previews: some View {
        ContactsPermission()
    }
}
    
    
