//
//  PersonItem.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI

struct PersonItem: View {
    var firstName: String
    var lastName: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            let first = firstName
            let second = lastName
            
            if first != "" && second != "" {
                Text("\(String(first.prefix(1)))\(String(second.prefix(1)))")
                    .frame(width: 70, height: 70, alignment: .center)
                    .background(Color.secondary.opacity(0.7))
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.secondary.opacity(0.7))
                    .frame(width: 70, height: 70)
            }

            Text("\(firstName)\n\(lastName)")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
        }
        .frame(width: 70)
    }
}

struct PersonItem_Previews: PreviewProvider {
    static var previews: some View {
        PersonItem(firstName: "", lastName: "")
    }
}

