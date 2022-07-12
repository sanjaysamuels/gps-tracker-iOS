//
//  MapFunctionality.swift
//  Lab5_UsingGPS
//
//  Created by Sanjay Sekar Samuel on 2022-06-28.
//

import Foundation

class MapFunctionality{
    
    let cons = Constances()
    
    var speeds: [Double] = [];
    var lat: [Double] = [];
    var long: [Double] = [];
    var accelerations: [Double] = [];
    var distances: [Double] = [];
    var totalDistanceBeforeSpeedLimit: [Double] = [];
    
    var speedInkm: Double = 0;
    
    
    func averageSpeedCalc(myArr: [Double]) -> Double{
        let sumArray = myArr.reduce(0, +)
        let avgArrayValue = sumArray / Double(myArr.count)
        
        let avgSpeedinKM = (avgArrayValue * 3600) / 1000
        return cons.outputFormatter(number: avgSpeedinKM)
    }
    
    //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    
    func speedChecker(speed: Double) -> Bool {
        if (speed > cons.speedLimit){
            return true
        } else{
            return false
        }
    }
    
    
    func accelerationCalc(speedStart: Double, speedNow: Double, time: Double) -> Double {
        return (speedNow - speedStart) / time
    }
    
    func speedLimExceed(dist: Double) {
        print(String(format: "The driver travelled %.2f km before reaching 115 km/hr", dist))
    }
    
    
    
    
}
