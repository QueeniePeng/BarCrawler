//
//  UserModel.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

class UserModel: DijkstraNode {
    let id: String
    let location: LocationModel
    
    init(location: LocationModel, name: String) {
        self.id = "user"
        self.location = location
        super.init(name: name)
    }
}
