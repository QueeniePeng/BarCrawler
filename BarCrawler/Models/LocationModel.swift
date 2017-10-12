//
//  LocationModel.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation
import CoreLocation

class LocationModel {
    let latitude: Double
    let longitude: Double
    
    var address: String?
    var city: String?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension LocationModel {
    func getDistanceFrom(_ location: LocationModel) -> Int {
        let coordinateA = CLLocation(latitude: self.latitude,
                                     longitude: self.longitude)
        let coordinateB = CLLocation(latitude: location.latitude,
                                     longitude: location.longitude)
        
        let distanceInMeters = coordinateA.distance(from: coordinateB)
        
        return Int(distanceInMeters)
    }
}
