//
//  BarCrawlerTests.swift
//  BarCrawlerTests
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import XCTest

@testable import BarCrawler

class BarCrawlerTests: XCTestCase {
    
    private let nodeA = DijkstraNode(name: "A")
    private let nodeB = DijkstraNode(name: "B")
    private let nodeC = DijkstraNode(name: "C")
    private var nodeD = DijkstraNode(name: "D")
    private let nodeE = DijkstraNode(name: "E")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Arrange
        nodeA.connections.append(DijkstraConnection(to: nodeB, weight: 1))
        nodeB.connections.append(DijkstraConnection(to: nodeC, weight: 3))
        nodeC.connections.append(DijkstraConnection(to: nodeD, weight: 6))
        nodeB.connections.append(DijkstraConnection(to: nodeE, weight: 1))
        nodeE.connections.append(DijkstraConnection(to: nodeC, weight: 2))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        nodeA.connections = []
        nodeB.connections = []
        nodeC.connections = []
        nodeB.connections = []
        nodeE.connections = []
    }
    
    func testCumulativeWeight() {
        
        // Arrange
        let sourceNode = nodeA
        let destinationNode = nodeD
        
        // Act
        let path = shortestPath(source: sourceNode, destination: destinationNode)
        
        // Assert
        XCTAssertEqual(path?.cumulativeWeight, 10)
    }
    
    func testSuccession() {
        
        // Arrange
        let sourceNode = nodeA
        let destinationNode = nodeD
        
        // Act
        let path = shortestPath(source: sourceNode, destination: destinationNode)
        let succession = path?.succession()
        
        // Assert
        XCTAssertEqual(succession!, ["A", "B", "C", "D"])
    }
    
}


