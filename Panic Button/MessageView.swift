//
//  MessageView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI

struct MessageView: View {
    @State var text = "Mensaje"
    @FocusState private var messageIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown = 10
    
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
                        ForEach(1...4, id: \.self) { _ in
                            PersonItem(image: "persona", name: "Antonio Gómez")
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
                        
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "paperplane.fill")
                                .padding(.trailing, 5)
                            
                            Text("Enviar mensaje")
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.black)

                }
            }
            .padding()
            .onTapGesture {
                messageIsFocused = false
            }

        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onReceive(timer) { time in
            if countdown <= 10 && countdown > 0 {
                countdown -= 1
            }
            
            if countdown == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
