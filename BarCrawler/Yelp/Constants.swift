//
//  Constants.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct Constants {
    
    static let accessToken: String = "z5hP5NPwbfF-VTF7hvJYfk1f9iJSW-hDWk6QI2qlPjfkAOFg-WoRHNxRbNaSNKvw6qYDZWmSs4e0jFNKGWYyfPheZ8XrcqTtko0_z-qYVlRW_Nk9ybzo6BvCJt6IWXYx"
    
    // barlistURL - query keys
    struct BarListQueryKeys {
        static let Term = "term"
        static let Price = "price"
        static let Limit = "limit"
        static let Radius = "radius"
        static let SortBy = "sort_by"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    // barlistURL - query values
    struct BarListQueryValues {
        static var limit = "10" // return only 10 results
        static var Term = "bars"
        static var Radius = "40000"
        static var Price = "1,2,3,4"
        static var SortBy = "best_match"
        static var Latitude = 41.89    // get from user
        static var Longitude = -87.62   // get from user
    }
}
