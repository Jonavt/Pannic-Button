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
    @FocusState private var messageIsFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Ingresa tus datos")
                .font(.largeTitle.weight(.heavy))
            
            Image("profileData")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                .frame(height: 300)
            

            CustomField(searchText: $username, text: "Nombre")
                .focused($messageIsFocused)
            CustomField(searchText: $lastName, text: "Apellidos")
                .focused($messageIsFocused)
            CustomField(searchText: $age, text: "Edad")
                .focused($messageIsFocused)
            
            
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
        .onTapGesture {
            messageIsFocused = false
        }
    }
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
    
}
