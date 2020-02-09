//
//  createdClassroomViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 10/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class createdClassroomViewController:  UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {
    let db = Firestore.firestore()
    var selectedSubject = ""
    var selectedLevel = ""
    var selectedSeme = ""
    var uniqueId = ""
    var teacherId = Auth.auth().currentUser?.uid
    var ID = ""
    
    @IBOutlet weak var IdLabel: UILabel!
    
    @IBOutlet weak var successView: UIView!
    
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
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
        successView.isHidden = true
        self.errorLabel.text = ""
        self.errorLabel.alpha = 0
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
                selectedSubject = subjects[row]
            pickerView1.isHidden = true
            }else  if pickerView == pickerView2
            {
                B2.setTitle(levels[row], for: .normal)
                selectedLevel=levels[row]
                pickerView2.isHidden = true
            }else  if pickerView == pickerView3 {
               B3.setTitle(semester[row], for: .normal)
                selectedSeme=semester[row]
                pickerView1.isHidden = true }
        }
    
    
    @IBAction func selectCreate(_ sender: Any) {
        if  getUniqueId() == false && addToDatabase() == false  {
            self.errorLabel.alpha = 1 }
        else{
             successView.isHidden = false
            // move to other screen
        IdLabel.text = self.uniqueId
        
            
    }}
    
    // validation
    
    
    
    
    
    
    
    // backend
    
    func addToDatabase() -> Bool {
        var done = false
        let newDoucument =  self.db.collection("sciences").document()
        ID = newDoucument.documentID
        newDoucument.setData(["id" : ID, "subject":selectedSubject ,  "level":selectedLevel,"semester":selectedSeme, "name":className.text as Any ,  "uniqeId" : self.uniqueId , "teacherId":teacherId]) { (error) in
            if error != nil {
                self.errorLabel.text = "لم يتم إنشاء الغرفة بنجاح"
            } else {
                done = true
            }}
        return done
    }// end method
        
    
    
    func getUniqueId()-> Bool {
        var done = false
        self.db.collection("sciences").document("uniqeId").getDocument { (DocumentSnapshot, error) in
            if error != nil {
            self.errorLabel.text = "لم يتم إنشاء الغرفة بنجاح"
            }else {
            var id = 0
                id = Int((DocumentSnapshot?.get("id") as! NSString ).intValue)
            id = id + 1
                self.uniqueId = String(id)
                self.db.collection("sciences").document(self.ID).updateData(["uniqeId" :self.uniqueId])
                self.db.collection("sciences").document("uniqeId").updateData(["id" :self.uniqueId])
        done = true
                
            }}
        return done
    }
}
