//
//  RepPercentageTableViewCell.swift
//  QuestionBot
//
//  Created by Will Said on 2/16/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class RepPercentageTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
