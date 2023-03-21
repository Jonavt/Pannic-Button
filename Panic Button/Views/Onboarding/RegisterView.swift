//
//  RegisterView.swift
//  Panic Button
//
//  Created by UDLAP13 on 09/03/23.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var lastName: String = ""
    @State var age: String = ""
    
    @State var showMessage = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Ingresa tus datos")
                .font(.largeTitle.weight(.heavy))
            
            Image("profileData")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
                .padding(.horizontal, 20)

            CustomField(searchText: $username, text: "Nombre")
            CustomField(searchText: $lastName, text: "Apellidos")
            CustomField(searchText: $age, text: "Edad")
            
            
            Spacer()
            Button {
                showMessage = true
            } label: {
                HStack {
                    Spacer()
                    Text("Siguiente")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .cornerRadius(15)
            .controlSize(.large)
        }
        .padding()
        .navigationDestination(isPresented: $showMessage) {
            DefineMessageView()
        }
    }
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
    
}
