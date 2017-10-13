//
//  BarListViewController.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit
import CoreLocation

class BarListViewController: UIViewController {
    
    fileprivate var barModels = [BarModel]()
    
    fileprivate let alert = Alert()
    fileprivate var userLocation: LocationModel?
    fileprivate let locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self

        checkLocationService()
        checkLocationAccess()
        getBarList()
    }
}

// MARK: - Networking: get

extension BarListViewController {
    func getBarList() {
        let yelpClient = YelpClient()
        yelpClient.barList { [weak self] (results, error) in
            if let error = error {
                print(error)
            }
            guard let results = results else { return }
            
            if results.isEmpty {
                print("Hey, You are in the middle of nowhere")
            } else {
                self?.sortBarList(results) // store bar data
            }
        }
    }
    // by distance
    func sortBarList(_ results: [BarModel]) {
        let sortedBarModels = results.sorted { $0.distanceFromUser! < $1.distanceFromUser! }
        self.barModels = sortedBarModels
    }
}

// MARK: - Core Location

extension BarListViewController: CLLocationManagerDelegate {
    
    // check location service enable
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 500 // meters
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            let alertController = alert.showAlert(.disableLocationService)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // check location access enable
    func checkLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        if status == .denied {
            let deniedAlert = alert.showAlert(.disableLocationAccess)
            present(deniedAlert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        
        if status == .denied {
            let deniedAlert = Alert().showAlert(.disableLocationAccess)
            present(deniedAlert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        // store current location data
        Constants.BarListQueryValues.Latitude = locationValue.latitude
        Constants.BarListQueryValues.Longitude = locationValue.longitude
        userLocation = LocationModel(latitude: locationValue.latitude, longitude: locationValue.longitude)
    }
}
