//
//  signUpViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

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

    @IBAction func signUpTapped(_ sender: Any) {
    }
}
