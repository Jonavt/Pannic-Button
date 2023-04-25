//
//  MessageView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct MessageView: View {
    @AppStorage("emergencyMessage") var text = ""
    @FocusState private var messageIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown = 59
    
    @Binding var showSuccess: Bool
    @FetchRequest(sortDescriptors: []) var savedContacts: FetchedResults<Contact>
    @EnvironmentObject var locVM: LocationViewModel
    
    @AppStorage("name") var username: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @State var showContacts = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 25) {
                Text("Mensaje")
                    .font(.largeTitle.weight(.heavy))
                    .padding([.horizontal, .top])
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Mensaje a enviar")
                            .font(.headline)
                        
                        TextEditor(text: $text)
                            .frame(maxHeight: 150)
                            .padding(10)
                            .scrollContentBackground(.hidden)
                            .background(.secondary.opacity(0.2))
                            .cornerRadius(15)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            .focused($messageIsFocused)
                        
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ubicación")
                            .font(.headline)
                        
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: "mappin.and.ellipse")
                            
                            if let location = locVM.currentPlacemark {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("\(location.name ?? "")")
                                    if let address = location.postalAddress {
                                        Text("\(address.street), \(address.postalCode), \(address.city), \(address.state), \(address.country)")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                }
                            } else {
                                Text("Sin dirección")
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                        .background(.secondary.opacity(0.2))
                        .cornerRadius(15)
                        
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Contacto de emergencia")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(savedContacts) { contact in
                                HStack {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 30))
                                    
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        
                                        Text("\(contact.firstName ?? "") \(contact.lastName ?? "")")
                                            .font(.title3.weight(.bold))
                                            .foregroundColor(.primary)
                                        
                                        Text("\(contact.phoneNumber ?? "")")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        buttonVibration()
                                        showContacts = true
                                    } label: {
                                        Label("Cambiar", systemImage: "gear")
                                    }
                                    .tint(.primary)
                                    .controlSize(.regular)
                                    .buttonStyle(.borderedProminent)
                                    .cornerRadius(15)
                                    .foregroundColor(Color("InvertedText"))
                                    .accessibilityLabel(Text("Cambiar"))
                                    .accessibilityHint(Text("Cambia el contacto de emergencia"))
                                }
                                .padding(10)
                                .background(LinearGradient(colors: [.green, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(15)
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: $showContacts) {
                            SeleccionarContactosView(isChanging: true)
                        }
                    }
                }
                
//                Spacer()
                
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
                .padding(.horizontal)
                
                HStack(alignment: .center, spacing: 15) {
                    Button {
                        buttonVibration()
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
                    .accessibilityLabel(Text("Cancelar"))
                    .accessibilityHint(Text("Cancela el envio del mensaje"))
                    
                    Button {
                        successVibration()
                        sendMessage(phoneNumber: (savedContacts.first?.phoneNumber!)!)
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "paperplane.fill")
                                .padding(.trailing, 5)
                            
                            Text("Enviar mensaje")
                            
                            Spacer(minLength: 0)
                        }
                        .foregroundColor(Color("InvertedText"))
                        .fixedSize(horizontal: true, vertical: false)
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.primary)
                    .accessibilityLabel(Text("Enviar mensaje"))
                    .accessibilityHint(Text("Te dirije a WhatsApp para enviar el mensaje"))
                }
                .padding([.horizontal, .bottom])
            }
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
                successVibration()
                sendMessage(phoneNumber: (savedContacts.first?.phoneNumber!)!)
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
        .onAppear {
            locVM.fetchAddress(for: locVM.locationManager.location)
        }
    }
    
    func sendMessage(phoneNumber: String) {
        guard let address = locVM.currentPlacemark?.postalAddress else { return }
        guard let locationName = locVM.currentPlacemark?.name else { return }
        let phone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let index = phone.index(phone.endIndex, offsetBy: -12)
        let finalPhone = phone.suffix(from: index).replacingOccurrences(of: " ", with: "")
        print(finalPhone)
        //                        let urlWhats = "whatsapp://send?text=\(text)\n\nMi última ubicación es:\n\(locationName)\n\(address.street), \(address.postalCode), \(address.city), \(address.state), \(address.country)"
        let urlWhats = "https://wa.me/\(finalPhone)?text=\(text)\n\nMi última ubicación es:\n\(locationName)\n\(address.street), \(address.postalCode), \(address.city), \(address.state), \(address.country)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL)
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
                else {
                    print("please install watsapp")
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(showSuccess: .constant(false))
            .environmentObject(LocationViewModel())
    }
}
