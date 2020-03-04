//
//  logOut.swift
//  HAK_V1
//
//  Created by Reem Almalki on 09/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
class logOut: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    func logOut(){

              let firebaseAuth = Auth.auth()
          do {
            try firebaseAuth.signOut()
              print("in after logout ")
        UserDefaults.standard.set(false, forKey: "IsUserSignedIn")
         UserDefaults.standard.synchronize()
              let alert = UIAlertController(title: "تم", message: "تم تسجيل الخروج", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "حسنا", style: .destructive, handler: nil))
                         self.present(alert, animated: true, completion: nil)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            
                 
            
          let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "signInViewController") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }

             topController.present(vc, animated: true, completion: nil)
                
            }
            
            

              
          } catch _ as NSError {
            print("error")
              let alert = UIAlertController(title: "تنبيه", message: "لم يتم تسجيل الخروج", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "حسنا", style: .destructive, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
              
              
          }
    }

}
