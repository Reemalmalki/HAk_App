//
//  singleClassViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 15/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseDatabase
class singleClassViewController: UIViewController {
var classId = ""
var userId = ""
    @IBOutlet weak var classIdLabel: UILabel!
    @IBOutlet weak var QRImg: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getDate() {
        let ref = Database.database().reference().child("sciences").child(userId).child(classId)
        ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.classIdLabel.text = value?["uniqueId"] as? String
    }

    

}
}
