//
//  profileViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 22/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class profileViewController: UIViewController {

    var teacherId = Auth.auth().currentUser?.uid

    @IBOutlet weak var nameLable: UILabel!
    
    
    @IBOutlet weak var emailLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
getProfileData()
        // Do any additional setup after loading the view.
    }
    
    func getProfileData(){
        let ref = Database.database().reference().child("teachers").child(!self.teacherId)
               ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                   let value = DataSnapshot.value as? NSDictionary
                   self.nameLable.text = value?["name"] as? String
                   self.emailLable.text = value?["email"] as? String
        }
        
    }
    
    
    @IBAction func editName(_ sender: Any) {
    }
    
    @IBAction func editEmail(_ sender: Any) {
    }
    
    @IBAction func editPassword(_ sender: Any) {
    }
    
}
