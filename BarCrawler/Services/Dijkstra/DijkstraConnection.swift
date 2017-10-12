//
//  DijkstraConnections.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

// MARK: - source: https://medium.com/swiftly-swift/dijkstras-algorithm-in-swift-15dce3ed0e22

class DijkstraConnection {
    public let to: DijkstraNode
    public let weight: Int
    
    public init(to node: DijkstraNode, weight: Int) {
        assert(weight >= 0, "weight has to be equal or greater than zero")
        self.to = node
        self.weight = weight
    }
}
