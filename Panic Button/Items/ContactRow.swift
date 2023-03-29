//
//  ContactRow.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/29/23.
//

import SwiftUI

struct ContactRow: View {
    var contact: ContactInfo
    @FetchRequest(sortDescriptors: []) var savedContacts: FetchedResults<Contact>
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            if let first = contact.firstName, let second = contact.lastName {
                Text("\(String(first.prefix(1)))\(String(second.prefix(1)))")
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color.secondary.opacity(0.7))
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.secondary.opacity(0.7))
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(contact.firstName) \(contact.lastName)")
                
                Text("\(contact.phoneNumber?.stringValue ?? "")")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if savedContacts.contains(where: { contact.phoneNumber?.stringValue == $0.phoneNumber}) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
                    .background(Color.primary.clipShape(Circle()))
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical)
        .background(.secondary.opacity(0.5))
        .cornerRadius(20)
        .overlay {
            ZStack {
                if savedContacts.contains(where: { contact.phoneNumber?.stringValue == $0.phoneNumber}) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.green, lineWidth: 3)
                        .padding(1.5)
                }
            }
        }
    }
}


struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: .init(firstName: "Arturo", lastName: "Diaz"))
    }
}
