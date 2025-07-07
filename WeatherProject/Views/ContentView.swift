//
//  ContentView.swift
//  WeatherProject
//
//  Created by Foundation-023 on 18/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State private var isSearching = false
    @State private var searchBar = ""
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let weather = weather {
                WeatherView(weather: weather, isSearching: $isSearching, searchBar: $searchBar, onSearch: {
                    Task {
                        do {
                            self.weather = try await weatherManager.getWeatherByCityName(city: searchBar)
                            searchBar = ""
                            isSearching = false
                        } catch {
                            print("Error getting weather: \(error)")
                        }
                    }
                }
                )
            } else {
                if let location = locationManager.location {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView().environmentObject(locationManager)
                    }
                }
            }
        }
        //        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(Color(.cyan))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
