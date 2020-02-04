//
//  signUpViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase

class signUpViewController: UIViewController {

    //..form fields
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var nationalId: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpForm()
        // Do any additional setup after loading the view.
    }
    
    func setUpForm(){
        //hide error msg
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
    
    func validateFields() -> String? {
        
        
        if name.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nationalId.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
    
            return "فضلًا تأكد/ي من تبعئة جميع الخانات"
            
        }
        
        
        
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "يجب أن تكون كلمة المرور  مكونة على الأقل من ٨ أحرف وتحتوي على الأقل أحد الرموز الخاصة التالية $@$#!%*?&"
            
        }
        
        if password.text!.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            return "يرجى التأكد من تطابق كلمة المرور وتأكيدها"
            
            
        }
        
        if nationalId.text!.count != 10   {
            return "يجب أن يتكون رقم الهوية الوطنية من ١٠ ارقام ويبدأ ب ١ أو ٢"
        }


        return  nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
        }
            
            
        else {
            
    let emailText=email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
            Auth.auth().createUser(withEmail: emailText, password: password.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
    }
    
    func showError(_ message:String) {
           
           errorMsg.text = message
           errorMsg.alpha = 1
       }
    
    
}
