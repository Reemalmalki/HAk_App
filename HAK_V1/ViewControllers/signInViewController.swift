//
//  signInViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth

class signInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInB: UIButton!
    
    
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpForm()
        // Do any additional setup after loading the view.
    }
    
    func setUpForm(){
        //hide errormsg
        errorMsg.alpha=0
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signInTapped(_ sender: Any) {
        // validate feilds
        
        // create clean version of fields
        let emailFeild = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // sign in user
        Auth.auth().signIn(withEmail:emailFeild , password: pass){
        (result , error) in
        if error != nil {
            self.errorMsg.text="البريد الإلكتروني او كلمة المرور خاطئة "
            self.errorMsg.alpha=1
        }
        else{
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.homeViewController) as? homeViewController
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
        
    }
}
}
