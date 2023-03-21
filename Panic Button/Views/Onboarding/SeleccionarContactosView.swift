//
//  SeleccionarContactosView.swift
//  Panic Button
//
//  Created by UDLAP14 on 09/03/23.
//

import SwiftUI

struct SeleccionarContactosView: View {
    @State private var searchText: String = ""
    @FocusState private var messageIsFocused: Bool

    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Contactos de emergencia")
                    .font(.largeTitle.weight(.heavy))
                
                
                CustomField(searchText: $searchText, image: "magnifyingglass", text: "Busca tus contactos")
                    //.padding(.horizontal)
                    .focused($messageIsFocused)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach((1...5), id: \.self){ item in
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .frame(width: 35, height: 35)
                                
                                Text("Nombre")
                                    .cornerRadius(25)
                                
                                Spacer()
                            }
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(15)
                            //Spacer()
                            
                        }
                    }
                    .padding(.top, 10)

                }
                
//                Spacer()
                
                Button {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 3)) {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Aceptar")
                        Spacer()
                    }
                }
                .padding()
                .font(.title3)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(15)

            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar(.hidden, for: .navigationBar)
        .onTapGesture {
            messageIsFocused = false
        }
    }
}

struct SeleccionarContactosView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionarContactosView()
    }
}


