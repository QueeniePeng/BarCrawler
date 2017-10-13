//
//  ResultsViewController.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    // view
    @IBOutlet weak var ResultTableView: UITableView!
    
    var barModels: [BarModel]?
    var userModel: UserModel?
    var destinationBar: BarModel?
    
    var sortedBarModels: [BarModel] = []
    
    fileprivate let resultCellIdentifier = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultTableView.dataSource = self
        calculateDijkstra()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Bar Crawler"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ResultTableView.rowHeight = UITableViewAutomaticDimension
        ResultTableView.estimatedRowHeight = 160
        ResultTableView.separatorStyle = .none
    }
}

// MARK: - Dijkstra

extension ResultsViewController {
    private func calculateDijkstra() {
        
        let barCrawlerService = BarCrawlerService(userModel: userModel!,
                                                  barModels: barModels!,
                                                  destinationBar: destinationBar!)
        if let sortedBarNames = barCrawlerService.getDijkstraPath() {
            for name in sortedBarNames {
                print("sorted: \(name)")
                sortedBarModels += barModels!.filter { $0.name == name }
                ResultTableView.reloadData()
                ResultTableView.separatorStyle = .singleLine
            }
        } else {
            print("can't bar crawwling for some unknown reason")
        }
    }
}


// MARK: - UITableViewDataSource

extension ResultsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedBarModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell = tableView.dequeueReusableCell(withIdentifier: resultCellIdentifier, for: indexPath) as! ResultCell
        let barModel = sortedBarModels[indexPath.row]
        resultCell.configResultCell(barModel: barModel)
        
        return resultCell
    }
}
