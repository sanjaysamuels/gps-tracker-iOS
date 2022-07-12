//
//  Constances.swift
//  Lab5_UsingGPS
//
//  Created by Sanjay Sekar Samuel on 2022-06-29.
//

import Foundation

struct Constances {
    let speedLimit = 115.00
    
    func outputFormatter(number: Double) -> Double {
        let output = round(number * 100) / 100.0
        return output
    }
}
