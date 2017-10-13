//
//  ResultCell.swift
//  BarCrawler
//
//  Created by pengQueenie on 2017/10/12.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var LBBarName: UILabel!
    @IBOutlet weak var LBBarAddress: UILabel!
}

extension ResultCell {
    func configResultCell(barModel: BarModel) {
        LBBarName.text = barModel.name
        LBBarAddress.text = barModel.location.address
    }
}
