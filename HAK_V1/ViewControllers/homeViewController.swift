//
//  homeViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    @IBOutlet weak var createClassroom: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    @IBAction func onClick(_ sender: UIButton) {
        
        let createClassroomViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.createClassroomViewController) as? createClassroomViewController
        self.view.window?.rootViewController = createClassroomViewController
        self.view.window?.makeKeyAndVisible()
    }
    */
}
