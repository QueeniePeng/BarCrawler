//
//  DijkstraNode.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

// MARK: - source: https://medium.com/swiftly-swift/dijkstras-algorithm-in-swift-15dce3ed0e22

class DijkstraNode {
    let name: String
    var visited = false
    var connections: [DijkstraConnection] = []
    
    init(name: String) {
        self.name = name
    }
    func reset() {
        self.visited = false
        self.connections = []
    }
}
