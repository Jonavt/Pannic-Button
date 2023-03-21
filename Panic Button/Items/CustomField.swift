//
//  SearchBar.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/21/23.
//

import SwiftUI

struct CustomField: View{
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


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomField(searchText: .constant(""))
    }
}
