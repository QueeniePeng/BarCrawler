//
//  DijkstraPath.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

// MARK: - source: https://medium.com/swiftly-swift/dijkstras-algorithm-in-swift-15dce3ed0e22

class DijkstraPath {
    public let cumulativeWeight: Int
    public let node: DijkstraNode
    public let previousPath: DijkstraPath?
    
    init(to node: DijkstraNode,
         via connection: DijkstraConnection? = nil,
         previousPath path: DijkstraPath? = nil) {
        if
            let previousPath = path,
            let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
}

extension DijkstraPath {
    var nodeArray: [DijkstraNode] {
        var nodeArray: [DijkstraNode] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
            nodeArray.append(path.node)
            
            iterativePath = path
        }
        return nodeArray
    }
    public func succession() -> [String] {
        return self.nodeArray.reversed().flatMap({$0}).map({$0.name})
    }
}
