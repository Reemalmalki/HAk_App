//
//  signInViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class signInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInB: UIButton!
    
    
    @IBOutlet weak var errorMsg: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
     
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
            let ref = Database.database().reference().child("teachers").child((result?.user.uid)!)
            ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
                if value?["type_of_user"] as? String != "teacher" {
                    
                    let alert = UIAlertController(title:"لا يمكن الدخول" , message: "عذراً ايها الطالب لا يسمح لك بالدخول لتطبيق المعلمين", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                          self.present(alert, animated: true, completion: nil)
                    
                } else {
                    UserDefaults.standard.set(true, forKey: "IsUserSignedIn")
                    UserDefaults.standard.synchronize()
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: "navigationBar")
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
    
        }
        
    }
        
    }

    
// tooDo
        @IBAction func resetPass(_ sender: Any) {
        let alert = UIAlertController(title: "نسيت كلمةالمرور؟", message: "ادخل البريد الإلكتروني الخاص بك لتصلك رسالة إعادة تعيين كلمة المرور", preferredStyle: .alert)
           alert.addTextField { (textField) in
               textField.placeholder = "********@**"
           }
           alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
           alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
            
            if self.isValidEmail((alert?.textFields![0].text)!) == true {
            
            Auth.auth().sendPasswordReset(withEmail: (alert?.textFields![0].text)! ) { error in}
        
         let alert = UIAlertController(title:"تم ارسال الرسالة" , message: "ستجد الرسالة في بريدك الإلكتروني", preferredStyle: .alert)
                
          alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            }else {
                
                let alert = UIAlertController(title:"لم يتم الإرسال " , message: "تأكد من بريدك الإلكتروني وحاول مرة اخرى", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                
                
            }
           })); self.present(alert, animated: true, completion: nil)
            
    }
    
   func isValidEmail(_ email: String) -> Bool {
          return email.count > 0 && NSPredicate(format: "self matches %@", "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}").evaluate(with: email)
      }

        
    }
        
     

