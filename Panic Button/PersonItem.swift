//
//  PersonItem.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI

struct PersonItem: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(Circle())
            
            Text(name)
                .font(.body)
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
        }
        .frame(width: 70)
    }
}

struct PersonItem_Previews: PreviewProvider {
    static var previews: some View {
        PersonItem(image: "persona", name: "Antonio")
    }
}
