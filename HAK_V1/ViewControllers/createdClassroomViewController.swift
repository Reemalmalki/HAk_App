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
    var sharedResourse = [String]()
   
    
    let semaphore = DispatchSemaphore(value: 1)
    let queue = DispatchQueue.global(qos: .background)
    override func viewDidLoad() {
        super.viewDidLoad()
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
       var done = false
       let qr = qrCode()
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
                    qr.uploadImg(uniqueId: self.uniqueId , userId : self.teacherId! , classId : DatabaseReference.key!  )
                                  }
               }
       
    }// end method 
    }// end class
    
    
  /*  func addToDatabase() -> Bool {
        let qr = qrCode()
        let URL : String = qr.uploadImg(uniqueId: self.uniqueId , id : teacherId!)
        if URL == "" {return false}
        print(URL)
        var done = true
        let ref = Database.database().reference().child("sciences")
        ref.child(teacherId as! String).childByAutoId().setValue(["id" : "", "subject":selectedSubject ,  "level":selectedLevel,"semester":selectedSeme, "name":className.text as Any ,  "uniqueId" : self.uniqueId , "teacherId":teacherId]) { (Error, DatabaseReference) in
            if Error != nil {
                self.errorLabel.text = "لم يتم إنشاء الغرفة بنجاح"
                done = false
            }else {
                DatabaseReference.updateChildValues(["uniqueId" : self.uniqueId ])
                DatabaseReference.updateChildValues(["url" : URL ])
                DatabaseReference.updateChildValues(["id" : DatabaseReference.key!  ])
                 ref.updateChildValues(["idIncremental" : self.uniqueId ])
                done = true
                           }
        }
        return done
       }// end method
        */
    
    

/*
class QRcode : UIViewController {
    
    var teacherId :String = ""
    var URL = ""
    
    required init?(coder: NSCoder) {
        
    }
    
    func uploadImg(uniqueId : String , id : String )-> String {
    let imageName:String = String("\(uniqueId).png")
        let image : UIImage = self.generateQRCode(from: uniqueId)!
        let ref = Storage.storage().reference().child("sciences").child(self.teacherId).child(imageName)
        // 1
        let imageData = image.jpegData(compressionQuality: 0.1)!

        // 2
        ref.putData(imageData, metadata: nil, completion: { (metadata, error) in
            
            // 3
            ref.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                   // return done
                }
                self.URL = url!.absoluteString
           
            })
        })
        return URL
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                let colorParameters = [
                       "inputColor0": CIColor(color: UIColor.purple), // Foreground
                       "inputColor1": CIColor(color: UIColor.clear) // Background
                   ]
                   let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)
                return UIImage(ciImage: colored)
            }
        }

        return nil
    }
    
    
}*/

