//
//  Alert.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class Alert {
    enum LocationError {
        case disableLocationService
        case disableLocationAccess
        case notUpdatedlocation
    }
    
    private let locationAlertTitle: String = "Location"
    private let locationServiceAlertMessage: String = "Location service not enable."
    private let locationAccessAlertMessage: String = "Bar Crawl requires location access to use the service."
    private let locationNotUpdatedAlertMessage: String = "We need your location to use BarCrawler."
    
    private func alertContent(_ locationError: LocationError) -> (title: String, message: String) {
        switch locationError {
        case .disableLocationService:
            return (title: locationAlertTitle, message: locationServiceAlertMessage)
        case .disableLocationAccess:
            return (title: locationAlertTitle, message: locationAccessAlertMessage)
        case .notUpdatedlocation:
            return (title: locationAlertTitle, message: locationNotUpdatedAlertMessage)
        }
    }
}

extension Alert {
    // settings + cancel options
    func showAlert(_ locationError: LocationError) -> UIAlertController {
        let content = alertContent(locationError)
        let alert = UIAlertController(title: content.title, message: content.message, preferredStyle: UIAlertControllerStyle.alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        return alert
    }
}
