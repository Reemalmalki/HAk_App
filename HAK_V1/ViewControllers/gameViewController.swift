//
//  gameViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 26/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class gameViewController: UIViewController {
    var classId = ""
    var userId = ""
    var gameId = ""
    var status : UIImage = UIImage(named:"icons8-padlock-50")!
    
    @IBOutlet weak var changeLabel: UILabel!
    
    
    @IBOutlet weak var gameGoals: UILabel!
    
    @IBOutlet weak var gameInstruction: UILabel!
    
    @IBOutlet weak var iconeView: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDate()
    }
    func getDate() {
        let ref = Database.database().reference().child("sciences").child("games").child(gameId)
        ref.observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
            let value = DataSnapshot.value as? NSDictionary
            self.gameGoals.text = value?["Goals"] as? String
            self.gameName.text = value?["Lesson"] as? String
            self.gameInstruction.text = value?["Instructions"] as? String
            self.iconeView.image = self.status
            if self.status == UIImage(named:"icons8-padlock-50") {
                self.switcher.isHidden = true
                self.changeLabel.isHidden = true
            }
        }
    } // end method getDate
    
    @IBAction func studentsProgress(_ sender: Any) {
    }
    
    @IBAction func changeStatus(_ sender: Any) {
        let alert = UIAlertController(title: "هل تريد فتح اللعبة", message: "لا يمكن اعادة غلقها مرة اخرى", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: { action in
         self.switcher.setOn(false, animated: true)
        }))
        alert.addAction(UIAlertAction(title: " تأكيد", style: .default, handler: { action in

            let ref = Database.database().reference().child("sciences").child(self.userId).child(self.classId).child("gamesList").child(self.gameId)
        let switchStatus:Bool = (sender as AnyObject).isOn
        if(switchStatus){
            ref.updateChildValues(["status" : "opened" ])
            self.status = UIImage(named:"icons8-padlock-50")!
            self.iconeView.image = self.status
            let alert = UIAlertController(title: "تنبيه", message: "تم اتاحة اللعبة للطلاب", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.switcher.setOn(true, animated: true)
            self.switcher.isHidden = true
            self.changeLabel.isHidden = true
            }
            })) ; self.present(alert, animated: true, completion: nil)
    }
    // changeStatus
    
    
    
    @IBAction func moveToGame(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "gameStatistics") as? gameStatisticsViewController
       // vc?.modalPresentationStyle = .fullScreen
        vc?.classId = self.classId
        vc?.gameid = self.gameId
        self.present((vc)!, animated: true, completion: nil)
        
        
    }
    
  
    
    
}
