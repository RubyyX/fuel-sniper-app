//
//  ContentView.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 24/11/21.
//

//  We can create other views but we get this main file to begin with. This file is linked to using the ContentView() function in the Fuel_SniperApp.swift file.

import SwiftUI


struct Fuel {
    let price: Double
}

private func getFuelPrices() -> [Fuel] { //Function that returns array of random prices (testing)
    var fuelPrices = [Fuel]() //Declare variable

    for _ in 1...20 {
        let fuel_cost = Fuel(price: Double.random(in: 100...200)) //Random int between 100-200
        fuelPrices.append(fuel_cost) //Append price to array
    }
    return fuelPrices
}

private func getTimeLabels() -> [String] {
    return (2015...2021).map {
        String($0)
    }
}

let menuColor = hex2RGB(hex: "168AAD")

struct ContentView: View {
    @State var circleProgress: CGFloat = 0.6
    @State var avgPrice: CGFloat = 40.26
    @State private var selectedFuelType = "Unleaded 95"
    // animation value
    @State private var animationAmount: CGFloat = 0

    let primaryColor = Color(red: 126 / 255, green: 63 / 255, blue: 143 / 255)
    let backColor = Color(.white)
    var ratings = ["Expensive", "Average", "Cheap"]
    let fuelTypes = ["Unleaded 95", "Unleaded 91", "Deisel"]

    var body: some View {
        VStack {
            // top panel
            VStack {
                // top info
                HStack {
                    Spacer()
                    // fuel picker
                    Picker("Select a fuel type", selection: $selectedFuelType) {
                        ForEach(fuelTypes, id: \.self) {
                            Text($0)
                        }
                    }

                        .pickerStyle(.menu)
                    Spacer()
                    // City
                    Text("ADELAIDE")
                        .foregroundColor(.white)

                    Spacer()
                }
                    .padding(.leading, 0)
            }
                .background(RoundedRectangle(cornerRadius: 10).fill(primaryColor))
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15))

            // middle Panel
            VStack {
                // makes width fill
                HStack {
                    Spacer()
                }
                // guage title
                Text("Today's Average Price AUD")
                    .foregroundColor(.white)
                    .font(.system(size: 20))

                // The guage and reading of avg city price
                ZStack {
                    // grey background circle
                    Circle()
                        .trim(from: 0.0, to: 1 / 4 * 3)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(Color(UIColor.white))
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: -225))

                    // guage circle
                    Circle()
                        .trim(from: 0.0, to: animationAmount * (circleProgress / 4 * 3))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(Color(UIColor(hue: CGFloat(circleProgress) / 3, saturation: 1.0, brightness: 1.0, alpha: 1.0)))

                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: -225))

                    // average price text
                    Text("\(Int(self.avgPrice))")
                        .font(.custom("HelveticaNeue", size: 40.0))
                        .foregroundColor(.white)
                        .bold()
                }
                    .padding(.top, 10)

                // rating based on circle progress
                if circleProgress == 0 {
                    Text(ratings[0])
                        .foregroundColor(.white)
                }
                else {
                    Text(ratings[Int(ceil(circleProgress * 3)) - 1])
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(.bottom, 5)
                }
            }
                .background(RoundedRectangle(cornerRadius: 10).fill(primaryColor))
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                .onAppear {
                // appear animation animationamount is CGFloat 0-1
                withAnimation(Animation.easeOut(duration: 1)) {
                    animationAmount = 1
                }
                
                //Testing the getPrices API function call
                var prices = [SitePrice]()
                    prices = getPrices(countryID: 3,
                    geoRegionLevel: 3,
                    geoRegionID: 3)
                dump(prices) //Outputs no elements => array empty
            }
                .onDisappear {
                animationAmount = 0
            }

            //3rd panel "graph"
            VStack() {
                let prices = getFuelPrices().map { Int($0.price) } //Prices array
                let labels = getTimeLabels() //Labels array

                LineChartView(values: prices, labels: labels) //Display graph by calling function
            }
                .background(RoundedRectangle(cornerRadius: 10).fill(primaryColor))
                .padding(.all)

            Spacer()

            //Vstack to handle menu text
            VStack() {
//                let prices = getPrices(countryID: 3,
//                                       geoRegionLevel: 3,
//                                       geoRegionID: 3)
//                Text(String(prices[0].Price))
                /*@START_MENU_TOKEN@*/Text("Menu Item 2")/*@END_MENU_TOKEN@*/
                /*@START_MENU_TOKEN@*/Text("Menu Item 3")/*@END_MENU_TOKEN@*/
            }
        }.background(backColor)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
