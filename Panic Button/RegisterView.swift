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
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
                Text("Ingresa tus datos")
                    .font(.largeTitle.weight(.bold))
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                
                Spacer()
                
            
                        TextField("Nombre", text: $username)
                .frame(width: 400, height: 40, alignment: .center)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
                        TextField("Apellido", text: $lastName)
                .frame(width: 400, height: 40, alignment: .center)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
                    TextField("Edad", text: $age)
                .frame(width: 400, height: 40, alignment: .center)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
            Spacer()
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("Siguiente")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .cornerRadius(0.25)
            .padding()
            .controlSize(.large)
        }
    }
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

}
