//
//  BarCell.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class BarCell: UITableViewCell {

    @IBOutlet weak var IVBarImage: UIImageView!
    @IBOutlet weak var LBBarName: UILabel!
    @IBOutlet weak var LBDistance: UILabel!
}

extension BarCell {
    func configBarCell(barModel: BarModel) {
        LBBarName.text = barModel.name
        IVBarImage.image = barModel.image
        LBDistance.text = String(describing: barModel.distanceFromUser!) + " meter"
    }
}
