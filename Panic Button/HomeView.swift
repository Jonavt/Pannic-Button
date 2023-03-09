//
//  InicioView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/9/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Text("Inicio")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                }
                .foregroundColor(.primary)
                .padding(5)
                .background(Color.secondary.opacity(0.2))
                .clipShape(Circle())
            }
            
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "speaker.wave.3.fill")
                        Text("Botón de \nPánico")
                            .font(.body)
                            .lineLimit(nil)
                    }
                    Spacer()
                }
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .padding(.vertical, 15)
                .frame(minHeight: 150)
                .background {
                    ZStack(alignment: .center) {
                        Color("Red")
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: 180, height: 180)
                        
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: 280, height: 280)
                        
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                            .frame(width: 380, height: 380)

                    }
                }
                .cornerRadius(20)
            }
            
            HStack(alignment: .center, spacing: 0) {
                Button {
                    
                } label: {
                    Label("Enviar mensaje", systemImage: "paperplane.fill")
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.black)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Label("Enviar mensaje", systemImage: "paperplane.fill")
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .cornerRadius(15)
                .accentColor(.secondary)
                
            }
            
//            Spacer()
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}