//
//  ViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        
        // set Gradient Background:
             view.setGradientBackground(colorOne: Colors.lightOrange, colorTwo: Colors.purple)

        
    }


}

