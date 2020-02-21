//
//  singleClassViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 15/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class singleClassViewController: UIViewController {
var classId = ""
var userId = ""
    @IBOutlet weak var classIdLabel: UILabel!
    @IBOutlet weak var QRImg: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getDate()
    }
    
    func getDate() {
        let ref = Database.database().reference().child("sciences").child(userId).child(classId)
        ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.classIdLabel.text = value?["uniqueId"] as? String
    

            let url = URL(string: (value?["url"] as? String)!)
            let data = try? Data(contentsOf: url!)
            self.QRImg.image = UIImage(data: data!)
        }
    } // end method getDate
    
    
    @IBAction func removeClassroom(_ sender: Any) {
       let ref = Database.database().reference().child("sciences").child(userId).child(classId)
    let qrRef = Storage.storage().reference().child("sciences").child(self.userId).child(self.classIdLabel.text!)
        let alert = UIAlertController(title: "تنبيه", message: "هل تريد حذف هذه الغرفة ؟", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: " تأكيد", style: .default, handler: { action in
            ref.removeValue()
             qrRef.delete()
            print("removed")
            let Home = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.homeViewController) as? homeViewController
                   self.view.window?.rootViewController = Home
                   self.view.window?.makeKeyAndVisible()
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func gamesList(_ sender: Any) {
    performSegue(withIdentifier: "gamesListViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gamesListViewController") {
            let vc = segue.destination as! gamesListViewController
            vc.classId = self.classId
        }
        if (segue.identifier == "studentsListViewController") {
            let vc = segue.destination as! studentsListViewController
           vc.classId = self.classId
           vc.userId = self.userId
        }
       }
    @IBAction func studentsList(_ sender: Any) {
    performSegue(withIdentifier: "studentsListViewController", sender: self)
    }

}
