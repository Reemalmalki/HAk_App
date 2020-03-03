//
//  ProfileViewController.swift
//  HAK_V1
//
//  Created by Raghad on 08/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class ProfileViewController: UIViewController{

      @IBOutlet weak var UserName: UILabel!
    
      @IBOutlet weak var UserEmail: UILabel!
    
     @IBOutlet weak var text: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
getCurrentTeacherInfo()
        
        // Do any additional setup after loading the view.
    }
    func getCurrentTeacherInfo(){
        
        
        
        guard let teacherId=Auth.auth().currentUser?.uid
            else {return }
        
        
        let ref = Database.database().reference()
        
        var TeacherName = ref.child("teachers").child(teacherId).value(forKey: "name")
        
          var TeacherEmail = ref.child("teachers").child(teacherId).value(forKey: "email")
        
        
        
        self.UserName.text=TeacherName as! String
        self.UserEmail.text=TeacherEmail as! String
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
