//
//  createdClassroomViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 10/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class createdClassroomViewController:  UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {
    var selectedSubject = ""
    var selectedLevel = ""
    var selectedSeme = ""
    var uniqueId = ""
    var teacherId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var classroomID: UILabel!
    
    
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
    
    let subjects = [ "", "العلوم" ]
    let levels = [ "" ,  "رابع ابتدائي" ]
    let semester = [ "" , "الفصل الدراسي الاول","الفصل الدراسي الثاني"  ]
    var sharedResourse = [String]()
   
    
    let semaphore = DispatchSemaphore(value: 1)
    let queue = DispatchQueue.global(qos: .background)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subView.isHidden = true
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
        let ref = Database.database().reference().child("sciences")
                  ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                   if DataSnapshot.exists(){
                      let value = DataSnapshot.value as? NSDictionary
                     var id = Int(value?["idIncremental"] as! String)!
                    id = id + 1
                       self.uniqueId = String(id)
                    }}
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
                pickerView3.isHidden = true }
        }
    
    
    @IBAction func selectCreate(_ sender: Any) {
        if self.selectedSubject == "" || self.selectedLevel == "" || self.selectedSeme == "" || className.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            self.errorLabel.text = "الرجاء تعبئة جميع الحقول"
            self.errorLabel.alpha = 1
            
            
        } else {
       var done = false
       let qr = qrCode()
            var image : UIImage = UIImage()
        //if URL == "" {done = false}
               let ref = Database.database().reference().child("sciences")
               ref.child(teacherId as! String).childByAutoId().setValue(["id" : "", "subject":selectedSubject ,  "level":selectedLevel,"semester":selectedSeme, "name":className.text as Any ,  "uniqueId" : self.uniqueId , "teacherId":teacherId]) { (Error, DatabaseReference) in
                   if Error != nil {
                       self.errorLabel.text = "لم يتم إنشاء الغرفة بنجاح"
                    self.errorLabel.alpha = 1
                    done = false
                   }else {
                  
                       DatabaseReference.updateChildValues(["uniqueId" : self.uniqueId ])
                       DatabaseReference.updateChildValues(["id" : DatabaseReference.key!  ])
                       ref.updateChildValues(["idIncremental" : self.uniqueId ])
                    image = qr.uploadImg(uniqueId: self.uniqueId , userId : self.teacherId! , classId : DatabaseReference.key!)
                   for i in 1..<6 {
                    DatabaseReference.child("gamesList").child("game\(i)").child("status").setValue("closed")
                    
                                  } // end for
              
                    self.subView.isHidden = false
                    self.imageView.image = image
                    self.classroomID.text = self.uniqueId
                    self.view.addSubview(self.subView)
                    
                    
                    
                    
        /* let showAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
           let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
            imageView.image = image  // Your image here...
            showAlert.view.addSubview(imageView)
                let imageViewIcone = UIImageView(frame: CGRect(x: 80, y: 0 , width: 100, height: 100))
               imageViewIcone.image = UIImage(named:"icons8-lock-50")
               showAlert.view.addSubview(imageViewIcone)
                    
                    
            let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
            let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
            showAlert.view.addConstraint(height)
            showAlert.view.addConstraint(width)
            showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                // your actions here...
            }))
            self.present(showAlert, animated: true, completion: nil)*/
            
            
            
            
      /* let alert = UIAlertController(title: "تم", message: "تم أنشاء الغرفة بنجاح", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { action in
                 let Home = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.homeViewController) as? homeViewController
                        self.view.window?.rootViewController = Home
                        self.view.window?.makeKeyAndVisible()
             }))
            self.present(alert, animated: true, completion: nil) }*/
            } //end else
            }
        }
    }// end method
  
    @IBAction func moveToHome(_ sender: Any) {
        // go home
    }
    
    
    }// end class
    
 

