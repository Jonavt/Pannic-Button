//
//  ContentView.swift
//  Panic Button
//
//  Created by UDLAP14 on 07/03/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.0549,
                                       longitude: -98.2845),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
            
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: .constant(true)) {
                HomeView()
                    .presentationDetents([.fraction(0.4)])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
