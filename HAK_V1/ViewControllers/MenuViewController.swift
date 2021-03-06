//
//  MenuViewController.swift
//  HAK_V1
//
//  Created by Raghad on 17/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
      func slideMenuItemSelectedAtIndex(_ index : Int32)
  }

class MenuViewController: UIViewController {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var navMenu: UIView!
    var btnMenu :UIButton!
 var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navMenu.setGradientBackground(colorOne: Colors.purple, colorTwo: Colors.pink)
        AppDelegate.setCornerRadiusOf(targetView: navMenu, radius: 20)

        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        
        let logout :logOut = logOut()
        
        logout.logOut()
        
    }
    
    
    @IBAction func profile(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(identifier: "profile")
    //vc?.modalPresentationStyle = .fullScreen
    self.present((vc)!, animated: true, completion: nil)
    }
}
