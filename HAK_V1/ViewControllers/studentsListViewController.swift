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
    var studentsFinishedGames : [String] = []
    var userId = ""
    var classId = ""
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
       
        let alert = UIAlertController(title: "إضافة طالب", message: "الرجاء ادخال رقم الطالب الخاص", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "12345"
        }
        alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "تأكيد", style: .default, handler: { [weak alert] (_) in
            userUniqueId = (alert?.textFields![0].text)!
          print(userUniqueId)
           if userUniqueId.elementsEqual("") {
                 let alert = UIAlertController(title:"لم تتم الاضافة" , message: "لم تتم الاضافة ، الرجاء المحاولة مرة اخرى", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
                      self.present(alert, animated: true, completion: nil) }
        }))
        self.present(alert, animated: true, completion: nil)
       

        
        // sarch for the user with that Id
        // use the uer id ad id in student list
        //succeseful message
    } // end addStudent
    

   
    @IBAction func deleteStudent(_ sender: Any) {
        // get Cellid
        guard
        let button = sender as? UIView,
        let cell = button.nearestAncestor(ofType: UICollectionViewCell.self),
        let view = cell.nearestAncestor(ofType: UICollectionView.self),
        let indexPath = view.indexPath(for: cell)
        else { return }
        // ref
        let ref = Database.database().reference().child("sciences").child(userId).child(classId).child("studentsList").child(self.studentsID[indexPath.item])
        // alter
            let alert = UIAlertController(title: "تنبيه", message: "هل تريد تأكيد الحذف ؟", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "إلغاء", style: .destructive, handler: nil))
                  alert.addAction(UIAlertAction(title: " تأكيد", style: .default, handler: { action in
                      ref.removeValue()
                  }))
                  self.present(alert, animated: true, completion: nil)
    }
    
  
    
    
    
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
        return studentsNames.count    }
     
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
                              let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                              label.center = self.view.center
                              label.textAlignment = .center
                              label.text = "لا يوجد طلاب "
                              self.view.addSubview(label)
                          }else{
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
                        self.studentsNames.append(value?["name"] as! String)
                        self.studentsScores.append(value?["score"] as! Double)
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
                        for i in self.studentsNames {
                            print(i)
                        }
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
