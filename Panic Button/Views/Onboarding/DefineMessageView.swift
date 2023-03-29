//
//  DefineMessageView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/21/23.
//

import SwiftUI

struct DefineMessageView: View {
    @AppStorage("emergencyMessage") var text = ""
    @FocusState private var messageIsFocused: Bool

    @Environment(\.dismiss) var dismiss
    @State var showPermissions = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Define tu Mensaje de Emergencia")
                .font(.largeTitle.weight(.heavy))
                .lineLimit(2, reservesSpace: true)
            
            Image("profileData")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
                .padding(.horizontal, 20)
                .frame(height: 300)
            
            TextEditor(text: $text)
                .frame(height: 150)
                .padding(10)
                .scrollContentBackground(.hidden)
                .background(
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        if text == "" {
                            Text("Define tu mensaje...")
                                .padding()
                                .foregroundColor(.secondary)
                        }
                        
                        Color.secondary.opacity(0.2)

                    }
                )
                .cornerRadius(15)
//                .ignoresSafeArea(.keyboard, edges: .bottom)
                .focused($messageIsFocused)

            
            
            Spacer()
            HStack(alignment: .center, spacing: 15) {
                Button {
                    dismiss()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        
                        Text("Atrás")
            
                        Spacer(minLength: 0)
                    }
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.secondary)
                
                
                Button {
                    showPermissions = true
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                                                
                        Text("Siguiente")
                            .foregroundColor(.white)
                        Spacer(minLength: 0)
                    }
                    .foregroundColor(Color("InvertedText"))
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.blue)
                .disabled(text.isEmpty)
            }
        }
        .padding()
//        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $showPermissions) {
            PermissionsView()
        }
        .onTapGesture {
            messageIsFocused = false
        }
    }
}

struct DefineMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DefineMessageView()
    }
}
