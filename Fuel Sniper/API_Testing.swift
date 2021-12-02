//
//  API_Testing.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 2/12/21.
//

import Foundation

var countryID = 21
var geoRegionLevel = 3
var geoRegionID = 4

func getPrices(countryID: Int, geoRegionLevel: Int, geoRegionID: Int) -> String {
    // Create URL
    var returnVal: String = "CodeError"
    let url = URL(string: "https://fppdirectapi-prod.safuelpricinginformation.com.au/Price/GetSitesPrices?countryId=21&geoRegionLevel=2&geoRegionId=189")
    guard let requestUrl = url else { fatalError() }
    // Create URL Request
    var request = URLRequest(url: requestUrl)
    // Specify HTTP Method to use
    request.httpMethod = "GET"
    // Set HTTP Request Header
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

        // Convert HTTP Response Data to a simple String
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            print("Response data string:\n \(dataString)")
            returnVal = String(data: data, encoding: .utf8)! //'!' Unwraps the optional string into a static string.
        }

    }
    task.resume()
    return returnVal
}


