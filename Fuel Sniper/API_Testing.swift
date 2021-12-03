//
//  API_Testing.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 2/12/21.
//

import Foundation

func parseJSONPrices(data: Data) -> Array<SitePrice> { //Return type is array of SitePrice objects
    var sitePricesArr = [SitePrice]() //Initialise site prices as array of 'site price objects'
    if let jsonPrices = try? JSONDecoder().decode(SitePrices.self, from: data) {
        sitePricesArr = jsonPrices.SitePrices
    }
    return sitePricesArr
}

func getPrices(countryID: Int, geoRegionLevel: Int, geoRegionID: Int) -> Array<SitePrice> {
    
    var result: Array<SitePrice> = []
    
    // Create URL
    let url = URL(string: "https://fppdirectapi-prod.safuelpricinginformation.com.au/Price/GetSitesPrices?countryId=" + String(countryID) + "&geoRegionLevel=" + String(geoRegionLevel) + "&geoRegionId=" + String(geoRegionID))
    guard let requestUrl = url else { fatalError() }
    
    var request = URLRequest(url: requestUrl) // Create URL Request
    request.httpMethod = "GET" // Specify HTTP Method to use and headers below
    request.setValue("FPDAPI SubscriberToken=52c12b44-b208-4b74-8109-70a3c2c3aaef", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Send HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        // Check if Error took place
        if let error = error {
            print("Error took place \(error)")
            return
        }

        // Read HTTP Response Status code
        if let response = response as? HTTPURLResponse {
            print("Response HTTP Status code: \(response.statusCode)")
        }

        guard let data = data else { return }
        result = parseJSONPrices(data: data) //Parse JSON data into result and return

    }
    
    task.resume()
    return result
}
