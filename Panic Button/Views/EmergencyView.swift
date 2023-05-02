//
//  EmergencyView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/16/23.
//

import SwiftUI

struct EmergencyView: View {
    @Environment(\.dismiss) var dismiss
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown = 10
    let emergencyNumber = "2281337838"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Llamar a emergencias")
                .font(.largeTitle.weight(.heavy))
                .minimumScaleFactor(0.7)
                .lineLimit(nil)
                    
            VStack(alignment: .center, spacing: 10) {
                Text("Llamando a emergencias en:")
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
                    buttonVibration()
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
                .accessibilityHint(Text("Cancela la llamada"))
                
                Button {
                    buttonVibration()
                    let tel = "tel://"
                    let formattedString = tel + emergencyNumber
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                    
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        
                        Image(systemName: "phone.fill")
                            .padding(.trailing, 5)

                        Text("Llamar")

                        Spacer(minLength: 0)
                    }
                    .foregroundColor(Color("InvertedText"))
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.primary)
                .accessibilityLabel(Text("Llamar"))
                .accessibilityHint(Text("Hace la llamada a emergencias"))
            }

            Spacer()
        }
        .padding()
        .padding(.top, 25)
        .onReceive(timer) { time in
//            if UIAccessibility.isVoiceOverRunning && countdown == 10 {
//                countdown = 20
//            }

            if countdown <= 10 && countdown > 0 {
                countdown -= 1
            }
            
            if countdown == 0 {
                let tel = "tel://"
                let formattedString = tel + emergencyNumber
                guard let url = URL(string: formattedString) else { return }
                UIApplication.shared.open(url)
                successVibration()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
        }
        .background(Color("Background1").ignoresSafeArea())

    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
