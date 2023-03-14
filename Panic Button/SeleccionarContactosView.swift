//
//  SeleccionarContactosView.swift
//  Panic Button
//
//  Created by UDLAP14 on 09/03/23.
//

import SwiftUI

struct SearchBar: View{
    @Binding var searchText: String
    
    var body: some View{
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $searchText)
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
    
}

struct SeleccionarContactosView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            
            Text("Selecciona tus contactos")
                .font(.largeTitle.bold())
            
            Spacer()
            
            SearchBar(searchText: $searchText)
                .padding()
            
            Spacer()
            
            
            ForEach((1...5), id: \.self){ item in
                HStack{
                    
                    Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 35, height: 35)
                    //.background(Color.green)
                    //.clipShape(Circle())

                    
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
            
            Button("Dar permiso"){
                
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

struct SeleccionarContactosView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionarContactosView()
    }
}
