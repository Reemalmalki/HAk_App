//
//  studentCollectionViewCell.swift
//  HAK_V1
//
//  Created by Reem Almalki on 26/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class studentCollectionViewCell: UICollectionViewCell {
    var studentId = ""
    var teacherId = ""
    var classId = ""
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var finishedGames: UILabel!
    
    @IBOutlet weak var studentScore: UILabel!
    
    
    @IBOutlet weak var rewardStudent: UIButton!
    
    
    @IBOutlet weak var deleteStudent: UIButton!
    
   
    
}// end class

