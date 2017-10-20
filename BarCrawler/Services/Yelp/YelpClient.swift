//
//  YelpClient.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

class YelpClient: NSObject {
    
    fileprivate var yelpRequest = YelpRequest()
    private let method = "GET"
    private let headerValue = "Bearer" + " " + Constants.accessToken
    private let headerField = "Authorization"
    
    func makeRequest(url: URL, method: String, headerValue: String, headerField: String) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(headerValue, forHTTPHeaderField: headerField)
        return request
    }
}

// get - barList
extension YelpClient {
    
    func barList(completion: @escaping (_ results: [BarModel]?, _ error: NSError?) -> Void) {
        guard let request = makeRequest(url: yelpRequest.barListURL!,
                                        method: method,
                                        headerValue: headerValue,
                                        headerField: headerField) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, error as NSError?)
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error as NSError?)
                }
                return
            }
            
            // decoder
            var barModels = [BarModel]()
            do {
                let decoder = JSONDecoder()
                let service = try decoder.decode(YelpBarService.self, from: data)
                for business in service.businesses {
                    let barModel = BarModel(id: business.id,
                                            name: business.name,
                                            city: business.location.city,
                                            distance: Int(business.distance),
                                            imageURL: business.imageURL,
                                            address: business.location.display_address,
                                            location: LocationModel(latitude: business.coordinates.latitude,
                                                                    longitude: business.coordinates.longitude))
                    barModels.append(barModel)
                }
                DispatchQueue.main.async {
                    completion(barModels, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            }
        }
        task.resume()
    }
}
