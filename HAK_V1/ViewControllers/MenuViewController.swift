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

    var btnMenu :UIButton!
 var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
