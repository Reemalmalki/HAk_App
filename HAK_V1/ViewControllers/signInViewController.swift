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
    }
    
    func setUpForm(){
        //hide errormsg
        errorMsg.alpha=0
        
    }
   
   func validateFields() -> String? {
    if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "فضلًا تأكد من تبعئة جميع الخانات" }
   return nil
    }
     
    @IBAction func signInTapped(_ sender: Any) {
        let validationError = validateFields()
        if validationError != nil {
            errorMsg.text = validationError
            errorMsg.alpha=1
            return  }
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
            UserDefaults.standard.set(true, forKey: "IsUserSignedIn")
            UserDefaults.standard.synchronize()
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.homeViewController) as? homeViewController
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
        
    }
        
        
}
    
// tooDo
        @IBAction func resetPass(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: "reemalamlki98@gmail.com" ) { error in
          // ...
        }
        }
   
        
    }
        
     

