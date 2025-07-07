//
//  WeatherView.swift
//  WeatherProject
//
//  Created by Foundation-023 on 20/06/25.
//

import SwiftUI

struct WeatherView: View {
    let weather: ResponseBody
    @Binding var isSearching: Bool
    @Binding var searchBar: String
    var onSearch: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(weather.name)
                            .bold().font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)
                    }
                    //                .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if isSearching {
                        HStack(spacing: 8) {
                            TextField("Search City...", text: $searchBar)
                                .padding(8)
                                .background(.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .frame(maxWidth: 250)
                            
                            Button(action: {
                                onSearch()
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(.blue)
                                    .clipShape(Circle())
                            }
                        }
                        .transition(.move(edge: .trailing))
                    } else {
                        Button(action: {
                            withAnimation {
                                isSearching = true
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(.gray.opacity(0.3))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                VStack {
                    HStack{
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string:"https://cdn.pixabay.com/photo/2020/02/29/17/14/wallpaper-4890663_1280.jpg")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now").bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min Temp. ", value: (weather.main.tempMin.roundDouble() + "°"))
                        Spacer()
                        
                        WeatherRow(logo: "thermometer", name: "Max Temp. ", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        Spacer()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        //        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(Color(.cyan))
        .preferredColorScheme(.dark)
    }
}

//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView(weather: previewWeather)
//    }
//}
