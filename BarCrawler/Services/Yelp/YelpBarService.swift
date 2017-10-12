//
//  YelpBarService.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct YelpBarService: Decodable {
    let total: Int
    let region: Region
    struct Region: Decodable {
        let center: Center
        struct Center: Decodable {
            let longitude: Double
            let latitude: Double
        }
    }
    let businesses: [Businesses]
    struct Businesses: Decodable {
        let id: String
        let name: String
        let imageURL: String
        let isClosed: Bool
        let url: String
        let reviewCount: Int
        let categories: [Categories]
        let rating: Double
        let coordinates: Coordinates
        let price: String
        let location: Location
        let phone: String
        let displayPhone: String
        let distance: Double
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageURL = "image_url"
            case isClosed = "is_closed"
            case url
            case reviewCount = "review_count"
            case categories
            case rating
            case coordinates
            case price
            case location
            case phone
            case displayPhone = "display_phone"
            case distance
        }
        
        struct Categories: Decodable {
            let alias: String
            let title: String
        }
        
        struct Coordinates: Decodable {
            let latitude: Double
            let longitude: Double
        }
        
        struct Location: Decodable {
            let address1: String?
            let address2: String?
            let address3: String?
            let city: String
            let zip_code: String?
            let country: String?
            let state: String?
            let display_address: [String]
        }
    }
}
