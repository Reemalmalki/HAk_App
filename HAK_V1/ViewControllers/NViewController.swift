//
//  NViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 24/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class NViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "IsUserSignedIn") == true {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.homeViewController) as? homeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
            print("Home")
        } else {
            let signInViewController = self.storyboard?.instantiateViewController(identifier: "signInViewController") as? signInViewController
                   self.view.window?.rootViewController = signInViewController
                   self.view.window?.makeKeyAndVisible()
               print("login")
            
        }
        // Do any additional setup after loading the view.
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
