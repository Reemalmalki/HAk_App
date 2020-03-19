//
//  gameTableViewCell.swift
//  HAK_V1
//
//  Created by Reem Almalki on 23/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class gameTableViewCell: UITableViewCell {

    
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var progressIcon: UIImageView!
    
    
    @IBOutlet weak var mainBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
