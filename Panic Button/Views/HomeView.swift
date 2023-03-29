//
//  InicioView.swift
//  Panic Button
//
//  Created by Arturo Diaz on 3/9/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.0549,
                                       longitude: -98.2845),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    @State var place = IdentifiablePlace(lat: 19.0549, long: -98.2845)
    
    @State var showMessage = false
    @State var showEmergency = false
    
    @EnvironmentObject var locVM: LocationViewModel
    
    @State var showSuccess = false
    @AppStorage("name") var username: String = ""

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 25) {
                HStack {
                    Text("Hola, **\(username)**")
                        .font(.largeTitle)
                    
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
                
                if let location = locVM.locationManager.location {
                    
                    Map(coordinateRegion: $locVM.region,
                        annotationItems: [place])
                    { place in
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                                  tint: Color.blue)
                    }
                    .frame(minHeight: 400)
                    .overlay(
                        Button(action: {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0)) {
                                locVM.region = MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                                   longitude: location.coordinate.longitude),
                                    latitudinalMeters: 750,
                                    longitudinalMeters: 750
                                )
                            }
                        }, label: {
                            if locVM.region.center.longitude != location.coordinate.longitude || locVM.region.center.latitude != location.coordinate.latitude {
                                Image(systemName: "location")
                                    .padding()
                                    .background(Color("Background1"))
                                    .foregroundColor(Color.blue)
                                    .clipShape(Circle())
                                    .padding(10)
                            }
                        })
                        , alignment: Alignment(horizontal: .trailing, vertical: .bottom)
                    )
                    .cornerRadius(20)
                } else {
                    Map(coordinateRegion: $locVM.region,
                        annotationItems: [place])
                    { place in
                        MapMarker(coordinate: place.location,
                                  tint: Color.blue)
                    }
                    .frame(minHeight: 400)
                    .cornerRadius(20)
                    
                }
                
                //            Spacer()
                
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
                
                HStack(alignment: .center, spacing: 15) {
                    Button {
                        showEmergency = true
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "phone.fill")
                                .padding(.trailing, 5)
                            
                            Text("Emergencias")
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.secondary)
                    
                    Button {
                        showMessage = true
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "paperplane.fill")
                                .padding(.trailing, 5)
                            
                            Text("Enviar mensaje")
                            
                            Spacer(minLength: 0)
                        }
                        .foregroundColor(Color("InvertedText"))
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(15)
                    .accentColor(.primary)
                    
                    
                }
            }
            .padding()
            .sheet(isPresented: $showMessage) {
                MessageView(showSuccess: $showSuccess)
            }
            .sheet(isPresented: $showEmergency) {
                EmergencyView()
                    .presentationDetents([.fraction(0.35)])
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear(perform: {
            Task { @MainActor in
                if let location = locVM.locationManager.location {
                    locVM.region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                       longitude: location.coordinate.longitude),
                        latitudinalMeters: 750,
                        longitudinalMeters: 750
                    )
                }
            }
        })
        .overlay {
            if showSuccess {
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        
                        VStack {
                            Image(systemName: "paperplane")
                                .font(.system(size: 50))
                            
                            Text("Mensaje enviado")
                                .font(.title.bold())
                            
                            Text("Se ha enviado el mensaje \na tus contactos de emergencia")
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .padding(.vertical, 40)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        
                        
                        Spacer()
                    }
                    .foregroundColor(.secondary)
                }
                .transition(.opacity)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationViewModel())
    }
}

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
