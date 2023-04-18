//
//  RegisterView.swift
//  Panic Button
//
//  Created by UDLAP13 on 09/03/23.
//

import SwiftUI

struct RegisterView: View {
    @AppStorage("name") var username: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("age") var age: String = ""
    
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
                .keyboardType(.numberPad)
            
            
            Spacer()
            Button {
                buttonVibration()
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
//            .opacity(isComplete() ? 1 : 0.4)
            .disabled(!isComplete())
            
        }
        .padding()
        .navigationDestination(isPresented: $showMessage) {
            DefineMessageView()
        }
        .onTapGesture {
            messageIsFocused = false
        }
    }
    
    func isComplete() -> Bool {
        var complete = false
        if !username.isEmpty && !lastName.isEmpty && (!age.isEmpty && age.isNumber) {
            complete = true
        }
        
        if let age = Int(age) {
            print(age)
            if age < 0 || age > 110 {
                complete = false
            }
        }
        
        return complete
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}
