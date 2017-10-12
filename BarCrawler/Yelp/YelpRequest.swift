//
//  YelpRequest.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct YelpRequest {
    
    // example
    // https://api.yelp.com/v3/businesses/search?price=1,2,3,4&location=60525&sort_by=best_match&radius=8000&term=bars
    
    var barListURL: Foundation.URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.yelp.com"
        urlComponents.path = "/v3/businesses/search"
        urlComponents.query = barListQuery()
        
        print(urlComponents.url!)
        return urlComponents.url
    }
}

extension YelpRequest {
    func barListQuery() -> String {
        let methodParameters = [
            Constants.BarListQueryKeys.Term: Constants.BarListQueryValues.Term,
            Constants.BarListQueryKeys.Limit: Constants.BarListQueryValues.limit,
            Constants.BarListQueryKeys.Price: Constants.BarListQueryValues.Price,
            Constants.BarListQueryKeys.Radius: Constants.BarListQueryValues.Radius,
            Constants.BarListQueryKeys.SortBy: Constants.BarListQueryValues.SortBy,
            Constants.BarListQueryKeys.Latitude: Constants.BarListQueryValues.Latitude,
            Constants.BarListQueryKeys.Longitude: Constants.BarListQueryValues.Longitude,
            ] as [String : Any]
        
        let barListQuery = escapedParameters(methodParameters as [String : AnyObject])
        return barListQuery
    }
    
    func escapedParameters(_ parameters: [String: AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                let stringValue = "\(value)"
                keyValuePairs.append(key + "=" + "\(stringValue)")
            }
            return "\(keyValuePairs.joined(separator: "&"))"
        }
    }
}
