//
//  createClassroomViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 08/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit

class createClassroomViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var subjectMenu: UITextField!
   
    @IBOutlet weak var levelMenu: UITextField!
    
    @IBOutlet weak var semesterMenu: UITextField!
    
    @IBOutlet weak var roomName: UITextField!
    
    @IBOutlet weak var errorLable: UILabel!
    
    
    @IBOutlet weak var createB: UIButton!
    
    let subjects = ["العلوم"]
    let levels = ["رابع ابتدائي"]
    let semester = ["الفصل الدراسي الاول","الفصل الدراسي الثاني"]
    var pickerView = UIPickerView()
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
      /* pickerView1.dataSource = self
        pickerView1.delegate = self
        pickerView2.dataSource = self
        pickerView2.delegate = self
        */
        subjectMenu.inputView = pickerView
        levelMenu.inputView = pickerView1
        semesterMenu.inputView = pickerView2
        errorLable.alpha = 0
    }
  

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{ return 1}

    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
       // if subjectMenu == subjectMenu {
        if component == 0{
            return subjects.count
            
        }
        //else if levelMenu == levelMenu
        else if levelMenu == levelMenu
        {return levels.count
        }
        else if semesterMenu==semesterMenu{
            return semester.count }else {return 0}
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if subjectMenu == subjectMenu {
        
            return subjects[row]
            
        }else if levelMenu == levelMenu
        {return levels[row]
        }else if semesterMenu==semesterMenu{ return semester[row] }else {return ""}}
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if subjectMenu == subjectMenu {
        
            subjectMenu.text = subjects[row]
            
        }else if levelMenu == levelMenu
        {levelMenu.text = levels[row]
        }else if semesterMenu==semesterMenu { semesterMenu.text = semester[row]  }
        
    }
   
}
