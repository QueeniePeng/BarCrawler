//
//  BarListViewController.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class BarListViewController: UIViewController {
    
    fileprivate var barModels = [BarModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
