//
//  signUpViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


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
        errorMsg.numberOfLines = 3
        errorMsg.adjustsFontSizeToFitWidth = true
        errorMsg.minimumScaleFactor = 0.5
        
    }
    
    
    func showError(_ message:String) {
           
           errorMsg.text = message
           errorMsg.alpha = 1
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
    
            return "فضلًا تأكد من تبعئة جميع الخانات"
            
        }
        
        
        
       let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedPassword.count < 6 {
            
            return "يجب أن تكون كلمة المرور  مكونة على الأقل من ٦ أحرف "
            
        }
        
        if password.text!.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            return "يرجى التأكد من تطابق كلمة المرور وتأكيدها"
            
            
        }
        
        if nationalId.text!.count != 10   {
            return "يجب أن يتكون رقم الهوية الوطنية من ١٠ ارقام ويبدأ ب ١ أو ٢"
        }
        if isValidEmailAddress(emailAddressString: email.text!) == false {
            return "فضلاً تاكد من البريد الالكتدوني"

        }

        return  nil
        
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch _ as NSError {
            returnValue = false
        }
        
        return  returnValue
    }

    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
        }
            
            
        else {
            
    let emailText=email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let nationalId_ = nationalId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let name_ = name.text!.trimmingCharacters(in: .whitespacesAndNewlines)
  
   
    
            Auth.auth().createUser(withEmail: emailText, password: password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, err) in
        if err != nil {
                          
                          // There was an error creating the user
            self.showError("لم يتم التسجيل بنجاح ! حاول مرة اخرى ")
                      }
        else {
            // User was created successfully, now store the first name and last name
            let ref = Database.database().reference().child("teachers")
            ref.child(result!.user.uid).setValue(["name":name_, "email":emailText , "nationalID":nationalId_, "type_of_user":"teacher"]) { (error, DatabaseReference) in
                              
            if error != nil {
                                  // Show error message
            self.showError("لم يتم التسجيل بنجاح ! حاول مرة اخرى ")
                              
            } else {
                // go to home
                UserDefaults.standard.set(true, forKey: "IsUserSignedIn")
                UserDefaults.standard.synchronize()
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "navigationBar")
                           self.view.window?.rootViewController = homeViewController
                           self.view.window?.makeKeyAndVisible()
            }
            
            }
        } // end else
    }
    

    
    
}
}
}
