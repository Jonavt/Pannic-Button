//
//  MessageView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI

struct MessageView: View {
    @AppStorage("emergencyMessage") var text = ""
    @FocusState private var messageIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown = 59
    
    @Binding var showSuccess: Bool
    @FetchRequest(sortDescriptors: []) var savedContacts: FetchedResults<Contact>

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 25) {
                Text("Mensaje")
                    .font(.largeTitle.weight(.heavy))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mensaje a enviar")
                        .font(.headline)
            
                    TextEditor(text: $text)
                        .frame(height: 150)
                        .padding(10)
                        .scrollContentBackground(.hidden)
                        .background(.secondary.opacity(0.2))
                        .cornerRadius(15)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .focused($messageIsFocused)

                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ubicación")
                        .font(.headline)
                    
                    
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "mappin.and.ellipse")
                        
                        Text("Universidad de las Américas Puebla")
                        
                        Spacer()
                    }
                    .padding(10)
                    .background(.secondary.opacity(0.2))
                    .cornerRadius(15)

                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contactos")
                        .font(.headline)
                    
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(savedContacts) { contact in
                            PersonItem(firstName: contact.firstName ?? "", lastName: contact.lastName ?? "")
                        }
                    }

                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: 10) {
                    Text("Enviando mensaje en:")
                        .font(.title3)
                        .bold()
                    
                    Text("\(countdown)")
                        .font(.largeTitle.weight(.heavy))

                }
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(.blue)
                .cornerRadius(15)
                .foregroundColor(.white)

                HStack(alignment: .center, spacing: 15) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            
                            Text("Cancelar")
                
                            Spacer(minLength: 0)
                        }
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.secondary)
                    
                    
                    Button {
                        dismiss()
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 1)) {
                            showSuccess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                    showSuccess = false
                                }
                            }
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "paperplane.fill")
                                .padding(.trailing, 5)
                            
                            Text("Enviar mensaje")
                            
                            Spacer(minLength: 0)
                        }
                        .foregroundColor(Color("InvertedText"))
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.primary)

                }
            }
            .padding()
            .onTapGesture {
                messageIsFocused = false
            }

        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onReceive(timer) { time in
            if countdown <= 59 && countdown > 0 {
                countdown -= 1
            }
            
            if countdown == 0 {
                dismiss()
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 1)) {
                    showSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                            showSuccess = false
                        }
                    }
                }
            }
        }
        .background(Color("Background1").ignoresSafeArea())
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(showSuccess: .constant(false))
    }
}
