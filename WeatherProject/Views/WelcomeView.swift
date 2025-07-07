//
//  WelcomeView.swift
//  WeatherProject
//
//  Created by Foundation-023 on 18/06/25.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the S'MART Weather App...\n😁😋").bold().font(.title)
                
                Text("Bagikan lokasi Mu saat ini untuk mengetahui cuaca di berbagai kota di Dunia\n\n(Klik tombol di bawah nihh...)").padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
