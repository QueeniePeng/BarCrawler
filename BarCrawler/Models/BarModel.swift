//
//  BarModel.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class BarModel: DijkstraNode {
    let id: String
    let location: LocationModel
    
    var price: String?
    var phone: String?
    var image: UIImage?
    var rating: Double?
    var distanceFromUser: Int?

    // MARK: cheating for user
    init(name: String,
         location: LocationModel) {
        self.id = "user"
        self.location = location
        super.init(name: name)
    }
    
    init(id: String,
         name: String,
         city: String,
         distance: Int,
         imageURL: String,
         address: [String],
         location: LocationModel) {
        
        self.id = id
        self.location = location
        self.location.city = city
        self.distanceFromUser = distance
        self.image = imageURL.urlToImage()
        self.location.address = address.joined(separator: " ")
        super.init(name: name)
    }
}

extension BarModel : Equatable {
    static func ==(lhs: BarModel, rhs: BarModel) -> Bool {
        return lhs.id == rhs.id
    }
}
