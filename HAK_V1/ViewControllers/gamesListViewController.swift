//
//  gamesListViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 25/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class gamesListViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    var data : [String] = []
    var dataImg :[UIImage] = []
    var cellId :[String] = []
    var selectedCell : String = ""
    var userId = ""
    var classId = ""
    var statusImg : UIImage = UIImage(named:"icons8-padlock-50")!
  override func viewDidLoad() {
        super.viewDidLoad()
getData()
        collectionView.delegate = self
              collectionView.dataSource = self
               let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
               layout.sectionInset = UIEdgeInsets(top: 40,left: 40,bottom: 15,right: 40 )
               let width = self.calculateWith()
               layout.itemSize = CGSize(width: 160, height: 180)
               collectionView?.setCollectionViewLayout(layout, animated: true)


}
    
    // backend
        func getData(){
            if Auth.auth().currentUser != nil {
                let user = Auth.auth().currentUser
                userId = user!.uid }
            // db ref
            let ref = Database.database().reference().child("sciences").child("games")
            let userGames = Database.database().reference().child("sciences").child(userId).child(classId).child("gamesList")
              // query + set data
           
                    ref.observe(.value) { snapshot in
                        
                        if snapshot.exists() == false {
                            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                            label.center = self.view.center
                            label.textAlignment = .center
                            label.text = "لا يوجد العاب مضافة"
                            self.view.addSubview(label)
                        }else{
                        for case let child as DataSnapshot in snapshot.children {
                        if let value = child.value as? [String:AnyObject]{
                        self.data.append(value["Lesson"] as! String)
                        self.cellId.append(child.key)}
                            
                        } // end for
                        }// end else
                        DispatchQueue.main.async{
                      self.collectionView.reloadData()}
                        }// end ret
            
            var status = ""
            userGames.observe(.value) { snapshot1 in
                if snapshot1.exists() == false {
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                    label.center = self.view.center
                    label.textAlignment = .center
                    label.text = "لا يوجد العاب مضافة"
                    self.view.addSubview(label)
                }else{
            for case let child1 as DataSnapshot in snapshot1.children {
                                   if let value = child1.value as? [String:AnyObject]{
                                       status = value["status"] as! String
                                       if status.elementsEqual("closed") {
                                      //cellIdStatus.append(status)
                                        self.dataImg.append(UIImage(named:"lock")!)
                                       }else {
                                        //cellIdStatus.append(status)
                                        self.dataImg.append(UIImage(named:"unlock")!)
                                       }
                                       
                }} // end for
                
                }
                DispatchQueue.main.async{
                 self.collectionView.reloadData()}
            } // end ref
     
           }// end method getData
    
    
    
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
          return data.count    }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! gamesCollectionViewCell
        cell.layer.cornerRadius = 18
        cell.layer.masksToBounds = true
          cell.gameName.text = data[indexPath.item]
          cell.iconView.image = dataImg[indexPath.item]
          cell.layer.borderColor = UIColor.white.cgColor
          cell.layer.borderWidth = 0.5
          cell.layer.borderColor = UIColor.gray.cgColor
          return cell
      }
    
    
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                  let cell = collectionView.cellForItem(at: indexPath)
                  cell?.layer.borderColor = UIColor.lightGray.cgColor
                  cell?.layer.borderWidth = 2
                cell?.layer.borderColor = UIColor.gray.cgColor
                self.selectedCell = cellId[indexPath.item]
        self.statusImg = dataImg[indexPath.item]
                performSegue(withIdentifier: "gameViewController", sender: self)
                }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! gameViewController
            vc.gameId = self.selectedCell
            vc.userId = self.userId
            vc.status =  self.statusImg
            vc.classId = self.classId
        
        }
        
              func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
                  let cell = collectionView.cellForItem(at: indexPath)
                  cell?.layer.borderColor = UIColor.white.cgColor
                  cell?.layer.borderWidth = 0.5
                cell?.layer.borderColor = UIColor.gray.cgColor
                
              }
    
    
    
    
} // end class
