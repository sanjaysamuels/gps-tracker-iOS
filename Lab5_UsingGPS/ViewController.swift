//
//  ViewController.swift
//  Lab5_UsingGPS
//
//  Created by Sanjay Sekar Samuel on 2022-06-27.
//

import UIKit
import MapKit
import CoreLocation




class ViewController: UIViewController {
    
    @IBOutlet weak var topBar: UILabel!
    @IBOutlet weak var bottomBar: UILabel!
    
    
    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var avgSpeedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var maxAccLabel: UILabel!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    let functionality = MapFunctionality()
    let cons = Constances()
    var time = 1
    
    let locationManager = CLLocationManager()
    
    var timer2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }

    @IBAction func startTrip(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        bottomBar.backgroundColor = .green
        timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.time += 1
        }
        
    }    
    
    @IBAction func stopTrip(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        bottomBar.backgroundColor = .gray
        
        // Resetting all the values
        self.time = 1
        timer2.invalidate()
        functionality.lat = []
        functionality.long = []
        functionality.speeds = []
        
        // Checking how many km the driver crossed the speed limit
        if (functionality.distances.isEmpty){
            print("The driver never crossed the speed limit!")
        } else{
            functionality.totalDistanceBeforeSpeedLimit.append(functionality.distances[0])
            functionality.speedLimExceed(dist: functionality.totalDistanceBeforeSpeedLimit.reduce(0, +))
        }
        
    }
}




extension ViewController: CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)
        
        myMapView.setRegion(region, animated: true)
        
        myMapView.showsUserLocation = true
        
        functionality.lat.append(locationManager.location!.coordinate.latitude)
        functionality.long.append(locationManager.location!.coordinate.longitude)
        functionality.speeds.append(locationManager.location!.speed)
        
        // Start location of user
        let startLoc = CLLocation(latitude: functionality.lat[0], longitude: functionality.long[0]);
        
        // Adding the pin
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: startLoc.coordinate.latitude, longitude: startLoc.coordinate.longitude)
        myMapView.addAnnotation(pin)
        
        // New location keeps updating with the users live location
        let newLoc = CLLocation(latitude: functionality.lat.last!, longitude: functionality.long.last!);
        let distanceInMeters = startLoc.distance(from: newLoc)
        let distInKM = distanceInMeters / 1000
        distanceLabel.text = "\(cons.outputFormatter(number: distInKM)) km"
        
        let speedInMPerSec = locationManager.location!.speed
        let speedInKmPerH = speedInMPerSec * 3.6
        functionality.speedInkm = speedInKmPerH
        currentSpeedLabel.text = "\(cons.outputFormatter(number: speedInKmPerH)) km/h"
        avgSpeedLabel.text = "\(functionality.averageSpeedCalc(myArr: functionality.speeds)) km/h"
        let maxSpeedInKmPerH = functionality.speeds.max()! * 3.6
        maxSpeedLabel.text = "\(cons.outputFormatter(number: maxSpeedInKmPerH)) km/h"
        
        let acceleration = functionality.accelerationCalc(speedStart: functionality.speeds[0], speedNow: functionality.speeds.last!, time: Double(time))
        functionality.accelerations.append(acceleration)
        maxAccLabel.text = "\(cons.outputFormatter(number: functionality.accelerations.max()!)) m/s^2"
        
        
     
        
        // Checking if the user crossed speed limit 
        if (functionality.speedChecker(speed: speedInKmPerH)) {
            topBar.backgroundColor = .red
            functionality.distances.append(distInKM)
            
        } else{
            topBar.backgroundColor = .clear
            functionality.distances.removeAll()
        }
        
    }
}

