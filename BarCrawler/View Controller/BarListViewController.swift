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
    
    // view
    @IBOutlet weak var BarListTableView: UITableView!
    
    fileprivate let alert = Alert()
    fileprivate var barModels = [BarModel]()
    fileprivate var userLocation: LocationModel?
    fileprivate let locationManager = CLLocationManager()
    fileprivate let barCellIdentifier = "barCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        BarListTableView.dataSource = self
        
        checkLocationService()
        checkLocationAccess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Bar Crawler"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        BarListTableView.rowHeight = UITableViewAutomaticDimension
        BarListTableView.estimatedRowHeight = 160
    }
    
    
    @IBAction func BarCrawl(_ sender: Any) {
        if userLocation == nil {
            let deniedAlert = alert.showAlert(.notUpdatedlocation)
            present(deniedAlert, animated: true, completion: nil)
        } else {
            getBarList()
        }
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
            self?.BarListTableView.reloadData()
        }
    }
    
    // sort by distance
    func sortBarList(_ results: [BarModel]) {
        let sortedBarModels = results.sorted { $0.distanceFromUser! < $1.distanceFromUser! }
        self.barModels = sortedBarModels
    }
}


// MARK: - UITableViewDataSource

extension BarListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let barCell = tableView.dequeueReusableCell(withIdentifier: barCellIdentifier, for: indexPath) as! BarCell
        if !barModels.isEmpty {
            let barModel = barModels[indexPath.row]
            barCell.configBarCell(barModel: barModel)
        }
        return barCell
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
