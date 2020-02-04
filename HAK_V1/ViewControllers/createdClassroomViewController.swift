//
//  createdClassroomViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 10/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase

class createdClassroomViewController:  UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {

    
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    
    @IBAction func selectSubject(_ sender: Any) {
        if pickerView1.isHidden { pickerView1.isHidden = false }
        if pickerView2.isHidden == false { pickerView2.isHidden = true }
        if pickerView3.isHidden == false { pickerView3.isHidden = true }
    }
    
    
    @IBAction func selectLevel(_ sender: Any) {
        if pickerView2.isHidden { pickerView2.isHidden = false }
        if pickerView1.isHidden == false { pickerView1.isHidden = true }
        if pickerView3.isHidden == false { pickerView3.isHidden = true }
    }
    
    
    @IBAction func selectSeme(_ sender: Any) {
        if pickerView3.isHidden { pickerView3.isHidden = false }
        if pickerView1.isHidden == false { pickerView1.isHidden = true }
        if pickerView2.isHidden == false { pickerView2.isHidden = true }
    }
    
    let subjects = ["اختر المادة","العلوم"]
    let levels = ["اختر المرحلة" , "رابع ابتدائي"]
    let semester = [ "الفصل الدراسي الاول","الفصل الدراسي الثاني" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // database
         // let db = Firestore.firestore()
         
        pickerView1.isHidden = true
        pickerView2.isHidden = true
        pickerView3.isHidden = true

        
        pickerView1.dataSource = self
        pickerView1.delegate = self
        pickerView2.dataSource = self
        pickerView2.delegate = self
        pickerView3.dataSource = self
        pickerView3.delegate = self
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{ return 1}
     
        
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            
           
            if pickerView == pickerView1 {
                return subjects.count
                
            }
            //else if levelMenu == levelMenu
            else if pickerView == pickerView2
            {
                return levels.count
            }
                else if pickerView == pickerView3{
                return semester.count }else {return 0}
            
        }
        
        
        func pickerView(_ pickerView : UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if pickerView == pickerView1 {
            
                return subjects[row]
                
            }else  if pickerView == pickerView2
            {return levels[row]
            }else  if pickerView == pickerView3 { return semester[row] }else {return ""}}
        
        
        func pickerView(_ pickerView : UIPickerView, didSelectRow row: Int, inComponent component: Int) {
              if pickerView == pickerView1 {
            B1.setTitle(subjects[row], for: .normal)
            pickerView1.isHidden = true
            }else  if pickerView == pickerView2
            {
                B2.setTitle(levels[row], for: .normal)
                pickerView2.isHidden = true
            }else  if pickerView == pickerView3 {
               B1.setTitle(semester[row], for: .normal)
                pickerView1.isHidden = true }
        }
       
    }
