//
//  homeViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase
class homeViewController: UIViewController {
    var userId = ""
    @IBOutlet weak var createClassroom: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        label.alpha = 1
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            userId = user!.uid
            
            label.text = "User is signed in." + userId
          // ...
        } else {
          label.text = "No user is signed in."
          // ...
        }
    }
    

    
    @IBAction func onClick(_ sender: UIButton) {
        
        let createdClassroomViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.createdClassroomViewController) as? createdClassroomViewController
        self.view.window?.rootViewController = createdClassroomViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}
