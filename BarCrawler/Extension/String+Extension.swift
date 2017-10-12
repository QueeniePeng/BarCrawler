//
//  String+Extension.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

extension String {
    func urlToImage() -> UIImage {
        let defaultImage = UIImage(named: "store")!
        if let url = URL(string: self) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)!
            } catch {
                print("******\n Canot convert data to image \n******")
                return defaultImage
            }
        } else {
            print("******\n image url not working \n******")
            return defaultImage
        }
    }
}
