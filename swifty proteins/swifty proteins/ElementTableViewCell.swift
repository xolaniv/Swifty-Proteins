//
//  ElementTableViewCell.swift
//  swifty proteins
//
//  Created by Xolani VILAKAZI on 2019/11/29.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    @IBOutlet weak var elementLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
