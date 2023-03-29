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

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("Llamar a emergencias")
                .font(.largeTitle.weight(.heavy))

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

            }

            Spacer()
        }
        .padding()
        .padding(.top, 25)
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
        .background(Color("Background1").ignoresSafeArea())

    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
