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
        self.getProfileData()
        // Do any additional setup after loading the view.
    }
    
    func getProfileData(){
        let ref = Database.database().reference().child("teachers").child(self.teacherId!)
               ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                   let value = DataSnapshot.value as? NSDictionary
                   self.nameLable.text = value?["name"] as? String
                   self.emailLable.text = value?["email"] as? String
        }
        
    }
    
    
    @IBAction func editName(_ sender: Any) {
        let alert = UIAlertController(title: "تعديل الاسم", message:"ادخل الاسم الجديد ثم اضغط على تأكيد", preferredStyle: .alert)
               alert.addTextField { (textField) in
                   textField.placeholder = "الاسم"
               }
               alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
               alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
                  let newName = (alert?.textFields![0].text)!
                if newName.elementsEqual("")  {
                   // error
                    let alert = UIAlertController(title:"لم يتم التعديل", message: "تأكد من الكتابة بشكل صحيح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                    
                }else{ // edit
                  let ref = Database.database().reference().child("teachers").child(self.teacherId!)
                    ref.updateChildValues(["name" : newName])
                    self.nameLable.text = newName
                    let alert = UIAlertController(title:"تم تعديل الإسم", message:"", preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                    
                }
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func editEmail(_ sender: Any) {
        
        let alert = UIAlertController(title: "تعديل البريد الإلكتروني", message:"ادخل البريد الإلكتروني الجديد ثم اضغط على تأكيد", preferredStyle: .alert)
               alert.addTextField { (textField) in
                   textField.placeholder = "******@****"
               }
               alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
               alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
                  let newEmail = (alert?.textFields![0].text)!
                if newEmail.elementsEqual("")  {
                   // error
                    let alert = UIAlertController(title:"لم يتم التعديل", message: "تأكد من الكتابة بشكل صحيح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                    
                }else{ // edit
                    Auth.auth().currentUser?.updateEmail(to: newEmail) { (error) in
                     
                        if error != nil { // error
                            let alert = UIAlertController(title:"لم يتم التعديل", message: "تأكد من الكتابة بشكل صحيح", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                             self.present(alert, animated: true, completion: nil)
                            
                        }else{
                            let ref = Database.database().reference().child("teachers").child(self.teacherId!)
                                               ref.updateChildValues(["name" : newEmail])
                                               self.emailLable.text = newEmail
                            let alert = UIAlertController(title:"تم تعديل البريد الإلكتروني", message:"", preferredStyle: .alert)
                                                                  alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                                                   self.present(alert, animated: true, completion: nil)
                        }
                        
                    } }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editPassword(_ sender: Any) {
               let alert = UIAlertController(title: "تعديل كلمة المرور", message:"ادخل كلمة المرور الجديدة ثم اضغط على تأكيد", preferredStyle: .alert)
                      alert.addTextField { (textField) in
                          textField.placeholder = "*********"
                      }
                      alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
                      alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
                         let newPass = (alert?.textFields![0].text)!
                       if newPass.elementsEqual("")  {
                          // error
                           let alert = UIAlertController(title:"لم يتم التعديل", message: "تأكد من الكتابة بشكل صحيح", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                           
                       }else{ // edit
                           Auth.auth().currentUser?.updatePassword(to: newPass) { (error) in
                            
                               if error != nil { // error
                                   let alert = UIAlertController(title:"لم يتم التعديل", message: "تأكد من الكتابة بشكل صحيح", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                   
                               }else{
                                let alert = UIAlertController(title:"تم التعديل كلمة المرور", message: "يمكنك استخدام كلمة المرور الجديدة عند تسجيل الدخول مرة اخرى", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                 self.present(alert, animated: true, completion: nil)
                                
                            }
                           } }
               }))
               self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
}
