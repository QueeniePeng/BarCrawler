//
//  BarCrawlerService.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

class BarCrawlerService {
    
    var userModel: UserModel
    var barModels: [BarModel]
    var destinationBar: BarModel
    
    var fullNodes: [BarModel] = []

    init(userModel: UserModel, barModels: [BarModel], destinationBar: BarModel) {
        self.userModel = userModel
        self.barModels = barModels
        self.destinationBar = destinationBar
    }
}

extension BarCrawlerService {
    
    func getDijkstraPath() -> [String]? {
        let userNode = BarModel(name: userModel.name, location: userModel.location)

        setNodes(userNode)
        setConnectionsWith(userNode)
        
        if let path = shortestPath(source: userNode, destination: destinationBar) {
            print("source: \(userNode.name). destination: \(destinationBar.name) Total Weight: \(path.cumulativeWeight)")
            let succession = path.succession()
            print(succession)
            return succession
        }
        return nil
    }
    
    func setNodes(_ userNode: BarModel) {
        fullNodes.append(userNode)
        fullNodes += barModels
    }
    
    func setConnectionsWith(_ userNode: BarModel) {
        // nested for loop
        for barA in fullNodes {
            for barB in fullNodes {
                if barA != barB {
                    if barA != userNode || barB != destinationBar { // can't go straight from user to destinationBar
                        let weight = barA.location.getDistanceFrom(barB.location)
                        barA.connections.append(DijkstraConnection(to: barB, weight: weight))
                        print("BarA: \(barA.name). BarB: \(barB.name). Weight: \(weight)\n")
                    }
                }
            }
        }
    }
}
