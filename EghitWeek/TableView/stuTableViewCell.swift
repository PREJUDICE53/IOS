//
//  stuTableViewCell.swift
//  TableView
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 wushan. All rights reserved.
//

import UIKit

class stuTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
