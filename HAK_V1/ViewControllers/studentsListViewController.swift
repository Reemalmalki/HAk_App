//
//  studentsListViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 26/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class studentsListViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource {
    var studentsNames : [String] = []
    var studentsScores : [Double] = []
    var studentsID : [String] = []
    var studentsUniqueID : [String] = []
    var studentsFinishedGames : [String] = []
    var userId = ""
    var classId = ""
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionView.delegate = self
                     collectionView.dataSource = self
                      let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                      layout.sectionInset = UIEdgeInsets(top: 10,left: 5,bottom: 2,right: 5 )
                      let width = self.calculateWith()
                      layout.itemSize = CGSize(width: width, height: width)
                      collectionView?.setCollectionViewLayout(layout, animated: true)
       
    }
    
    
    @IBAction func addStudent(_ sender: Any) {
    
    var userUniqueId = ""
      // alter the user for the user id
        let alert = UIAlertController(title: "إضافة طالب", message: "الرجاء ادخال رقم الطالب الخاص الذي يتكون من ٥ خانات فقط باللغة الانجليزية", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "1D3f5"
        }
        alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
            userUniqueId = (alert?.textFields![0].text)!
            if userUniqueId.elementsEqual("") || userUniqueId.count >= 6 {
                 let alert = UIAlertController(title:"لم تتم الاضافة" , message: "لم تتم الاضافة ، الرجاء المحاولة مرة اخرى", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil) } else {
                var isExist = false
                // student is already add
                for id in self.studentsUniqueID {
                    if userUniqueId == id {
                        isExist = true
                        let alert = UIAlertController(title:"لم تتم الاضافة" , message: "الطالب مضاف من قبل", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                             self.present(alert, animated: true, completion: nil)
                        break
                    } // end if
                
                }// end for
              if(isExist == false){
                    // get the student id
                    let userInfoRef = Database.database().reference().child("students")
                                         userInfoRef.observe(.value) { snapshot in
                                             if snapshot.exists() == false {
                                                print(" exists enterd")
                                        let alert = UIAlertController(title:"لم تتم الاضافة" , message: "لم تتم الاضافة ، الرجاء المحاولة مرة اخرى", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                                             }else{
                                             for case let child as DataSnapshot in snapshot.children {
                                             if let value = child.value as? [String:AnyObject]{
                                                if(value["studentID"] as! String == userUniqueId){
                                           let ref = Database.database().reference().child("sciences").child(self.userId).child(self.classId).child("studentsList")
                                                   ref.child(child.key).setValue(["progress" : "0"])
                                    for i in 1...4{
                                        let ref1 = Database.database().reference().child("sciences").child(self.userId).child(self.classId).child("gamesList").child("game\(i)").child("studentsScores")
                                         ref1.updateChildValues([child.key: 0])
                                                    }
                                                                                                      
                                                    
                                                    
                                                }
                                                self.label.isHidden = true
                                                } // end if
                                             }// end for
                                            }}
                } }// end else
    }))
        self.present(alert, animated: true, completion: nil)
        
    } // end addStudent
    

   
    @IBAction func deleteStudent(_ sender: Any) {
        // get Cellid
        guard
        let button = sender as? UIView,
        let cell = button.nearestAncestor(ofType: UICollectionViewCell.self),
        let view = cell.nearestAncestor(ofType: UICollectionView.self),
        let indexPath = view.indexPath(for: cell)
        else { return }
        let name = self.studentsNames[indexPath.item]
        // ref
        
        let ref = Database.database().reference().child("sciences").child(userId).child(classId).child("studentsList").child(self.studentsID[indexPath.item])
        // alter
            let alert = UIAlertController(title: "تنبيه", message: "هل تريد تأكيد الحذف ؟", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
                  alert.addAction(UIAlertAction(title: " تأكيد", style: .default, handler: { action in
                      ref.removeValue()
                    self.studentsID.remove(at: indexPath.item)
                    self.studentsUniqueID.remove(at: indexPath.item)
                    if self.studentsID.count == 0 {
                      
                        print("enterd if")
                        var indexPaths = [IndexPath]()
                        indexPaths.append(indexPath)
                        self.collectionView?.deleteItems(at: indexPaths)
                          self.label.isHidden = false
                    }
                    let alert = UIAlertController(title: "تم حذف الطالب", message: " الطالب\(name) تم حذفه من الغرفة ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسنا", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                  }))
                  self.present(alert, animated: true, completion: nil)
    }
    
  
    @IBAction func rewardStudent(_ sender: Any) {
        var point = ""
             // alter the user for the user id
        let alert = UIAlertController(title: "مكافأة طالب", message :"ادخل القيمة العددية التي تريد مكافأة الطالب بها وسيتم إضافتها الى نقاطه" , preferredStyle: .alert)
               alert.addTextField { (textField) in
                   textField.placeholder = "50"
               }
               alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
               alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
                   point = (alert?.textFields![0].text)!
                   print("user interd "+point)
                if point.elementsEqual("") || Double(point) == nil  {
                        let alert = UIAlertController(title:"حاول مرة اخرى" , message: "تأكد من كتابة الرقم بشكل صحيح", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil) } else {
                       // get user Id

                    guard
                    let button = sender as? UIView,
                    let cell = button.nearestAncestor(ofType: UICollectionViewCell.self),
                    let view = cell.nearestAncestor(ofType: UICollectionView.self),
                    let indexPath = view.indexPath(for: cell)
                    else { return }
                    let doublePoints = Double(point)! + self.studentsScores[indexPath.item]
                           // update student points
                    let userInfoRef = Database.database().reference().child("students").child(self.studentsID[indexPath.item])
                    userInfoRef.updateChildValues(["Points":  doublePoints])
                    self.studentsScores[indexPath.item] = doublePoints
                    var indexPaths = [IndexPath]()
                   indexPaths.append(indexPath)

                    if let collectionView = self.collectionView {
                        collectionView.reloadItems(at: indexPaths)
                    }
                     let alert = UIAlertController(title:"تم تقديم المكافأة بنجاح" , message: "تم تحديث نقاط الطالب", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                        }// end else
           }))
        self.present(alert, animated: true, completion: nil)
 
    } // endrewardStudent
    
    
    
    // view
      func calculateWith() -> CGFloat {
          let estimateWidth = 140.0
          let cellMarginSize = 16.0
          let estimatedWidth = CGFloat(estimateWidth)
          let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
          
          let margin = CGFloat(cellMarginSize * 2)
          let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
          
          return width
      }
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studentsID.count    }
     
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCell", for: indexPath) as! studentCollectionViewCell
          cell.layer.cornerRadius = 18
          cell.layer.masksToBounds = true
            cell.studentName.text = studentsNames[indexPath.item]
            cell.studentScore.text = "\(studentsScores[indexPath.item])"
            cell.finishedGames.text = studentsFinishedGames[indexPath.item]
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
          
            return cell
        }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    let cell = collectionView.cellForItem(at: indexPath)
                    cell?.layer.borderColor = UIColor.gray.cgColor
                    cell?.layer.borderWidth = 1
                  }
          
                func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
                    let cell = collectionView.cellForItem(at: indexPath)
                    cell?.layer.borderColor = UIColor.white.cgColor
                    cell?.layer.borderWidth = 0.5
                    cell?.layer.borderColor = UIColor.lightGray.cgColor
                  
                }
      
   
    
    // backend
         func getData(){
              // db ref
            let ref = Database.database().reference().child("sciences").child(userId).child(classId).child("studentsList")
              let userInfoRef = Database.database().reference().child("students")
                      ref.observe(.value) { snapshot in
                          if snapshot.exists() == false {
                            self.label.center = self.view.center
                            self.label.textAlignment = .center
                            self.label.text = "لا يوجد طلاب "
                            self.view.addSubview(self.label)
                          }else{
                            self.studentsID.removeAll()
                            self.studentsScores.removeAll()
                            self.studentsUniqueID.removeAll()
                            self.studentsFinishedGames.removeAll()
                             self.studentsNames.removeAll()
                          for case let child as DataSnapshot in snapshot.children {
                          if let value = child.value as? [String:AnyObject]{
                           self.studentsID.append(child.key )
                           self.studentsFinishedGames.append(value["progress"] as! String)
                           
                          } // end if
                          }// end for
                              
                        let group = DispatchGroup()

                    for singleUser in self.studentsID{
                        group.enter()
                        userInfoRef.child(singleUser).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        self.studentsNames.append(value?["Name"] as! String)
                        self.studentsScores.append(value?["Points"] as! Double)
                        self.studentsUniqueID.append(value?["studentID"] as! String)
                        group.leave()
                       }) { (error) in
                        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                         label.center = self.view.center
                     label.textAlignment = .center
                    label.text = "لا يوجد طلاب "
                        self.view.addSubview(label)
                        group.leave()
                        }
                     }
                                                 
                       group.notify(queue: .main) {
                        DispatchQueue.main.async{
                        self.collectionView.reloadData()}
                        }
                    
                                                        
                            
                        }// end else
                          }// end ret
            
            
             }// end method getData
      
      
}
extension UIView {
    func nearestAncestor<T>(ofType type: T.Type) -> T? {
        if let me = self as? T { return me }
        return superview?.nearestAncestor(ofType: type)
    }
}
