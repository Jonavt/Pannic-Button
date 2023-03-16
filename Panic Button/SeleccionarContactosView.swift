//
//  SeleccionarContactosView.swift
//  Panic Button
//
//  Created by UDLAP14 on 09/03/23.
//

import SwiftUI

struct SeleccionarContactosView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 25) {
                Text("Selecciona tus contactos de emergencia")
                    .font(.largeTitle.bold())
                
                
                SearchBar(searchText: $searchText, image: "magnifyingglass", text: "Busca tus contactos")
                    .padding(.horizontal)
                
                
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
                        .padding(.horizontal)
                        //Spacer()
                        
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
                Button {
                    
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
                .padding()

            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
}

struct SeleccionarContactosView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionarContactosView()
    }
}


struct SearchBar: View{
    @Binding var searchText: String
    var image = ""
    var text = ""
    @FocusState private var isSearchBarFocused: Bool
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                if image != "" {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.secondary)
                }
                
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(text)
                            .foregroundColor(.secondary)
                    }
                    TextField("", text: $searchText)
                        .focused($isSearchBarFocused)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .font(.system(size: 17))
                
                
                if searchText != "" {
                    Button(action: {
                        searchText = ""
                        isSearchBarFocused = true
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15, alignment: .center)
                            .padding(-2)
                            .foregroundColor(Color.primary)
                    })
                    .padding(.trailing, -4)
                }
            }
            .padding(16)
            .background(.ultraThinMaterial)
            .foregroundColor(.primary)
            .cornerRadius(15)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(height: 55)
    }
    
    
}
