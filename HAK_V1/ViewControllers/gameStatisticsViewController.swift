//
//  gameStatisticsViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 23/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class gameStatisticsViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    var gameid = "" 
    var classId = ""
    let userId = (Auth.auth().currentUser?.uid)!
    var numOfDone = 0
    @IBOutlet weak var tableView: UITableView!
    var names : [String] = []
    var scores : [Double] = []
    var ids : [String] = []
    let doneIcone = UIImage(named:"icons8-ok-48")
    let notDoneIcone = UIImage(named:"icons8-ok-48-2")

    @IBOutlet weak var prograssLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameTableViewCell",
                                                 for: indexPath) as! gameTableViewCell

        cell.nameLable.text = names[indexPath.row]
        for  _ in self.scores {
                if scores[indexPath.row] != 0 {
                    numOfDone = numOfDone + 1
                    cell.scoreLable.text = "\(scores[indexPath.row])"
                cell.mainBackground.layer.borderColor = UIColor.green.cgColor
                    cell.mainBackground.layer.borderWidth = 0.5
                    cell.progressIcon.image = doneIcone
                    
                }else{
                    cell.scoreLable.text = "0"
                    cell.progressIcon.image = notDoneIcone
            }
            
        }
        cell.mainBackground.layer.cornerRadius = 8
        cell.mainBackground.layer.masksToBounds = true
        cell.isUserInteractionEnabled = false;
        
        
        return cell
    }

 
    
    func getData(){
                 // db ref
         let ref = Database.database().reference().child("sciences").child(userId).child(classId).child("studentsList")
                         ref.observe(.value) { snapshot in
                             if snapshot.exists() == false {
                              // not exists
                             }else{
                               self.names.removeAll()
                               self.ids.removeAll()
                               self.scores.removeAll()
                             for case let child as DataSnapshot in snapshot.children {
                                if (child.value as? [String:AnyObject]) != nil{
                              self.ids.append(child.key )
                             } // end if
                             }// end for
                                self.prograssLable.text = "\(self.numOfDone)"+" طلاب من اصل "+" \(self.ids.count) " + "طالب انهوا اللعبة بنجاح"
                       
                                let ref1 = Database.database().reference().child("sciences").child(self.userId).child(self.classId).child("gamesList").child(self.gameid).child("studentsScores")

                                
                                ref1.observe(.value) { snapshot in
                                                            if snapshot.exists() == false {
                                                             // not exists
                                                            }else{
                                                               let values = snapshot.value as! [String:AnyObject]
                                                                
                                                                for (_, value) in values {
                                                                    self.scores.append(value as! Double)
                                                                }
                                                                
                                                                
                                                                
                                                               
                                    }}
                         let userInfoRef = Database.database().reference().child("students")
                        let group = DispatchGroup()
                       for singleUser in self.ids{
                           group.enter()
                           userInfoRef.child(singleUser).observeSingleEvent(of: .value, with: { (snapshot) in
                           // Get user value
                           let value = snapshot.value as? NSDictionary
                           self.names.append(value?["Name"] as! String)
                           group.leave()
                          }) { (error) in
                           // error
                           group.leave()
                           }
                        }
                                                    
                          group.notify(queue: .main) {
                           DispatchQueue.main.async{
                           self.tableView.reloadData()}
                           }
                       
                                                           
                            }}
               
                }// end method getData
         
    
    
    
}
