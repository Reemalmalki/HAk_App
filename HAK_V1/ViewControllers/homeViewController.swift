//
//  homeViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class homeViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource {
    var userId = ""
    var estimateWidth = 140.0
    var cellMarginSize = 16.0
    @IBOutlet weak var createClassroom: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
var data : [String] = []
var dataImg :[UIImage] = []
var cellId :[String] = []
    var selectedCell : String = ""
    
    @IBOutlet weak var classroomNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
       collectionView.delegate = self
       collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10,left: 5,bottom: 2,right: 5 )
        let width = self.calculateWith()
        layout.itemSize = CGSize(width: width, height: width)
        collectionView?.setCollectionViewLayout(layout, animated: false)
   
            
        
    }
        func getData(){
            let db = Firestore.firestore()
                
                if Auth.auth().currentUser != nil {
                    let user = Auth.auth().currentUser
                    userId = user!.uid
            db.collection("sciences").whereField("teacherId", isEqualTo: userId)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {// No classrooom
                        if querySnapshot?.count == 0 {
                            
                         print("No classroom ")
                        }else {
                        for document in querySnapshot!.documents {
                            self.data.append(document.get("name") as! String)
                            self.dataImg.append(UIImage(named:"img1-1")!)
                            self.cellId.append(document.get("id") as! String)

                            }
                         
                            DispatchQueue.main.async{
                              self.collectionView.reloadData()
                            }
                        }
                    }
            }
        }
    
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.className.text = data[indexPath.item]
        cell.image.image = dataImg[indexPath.item]
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
          }
          
          func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
              let cell = collectionView.cellForItem(at: indexPath)
              cell?.layer.borderColor = UIColor.white.cgColor
              cell?.layer.borderWidth = 0.5
            cell?.layer.borderColor = UIColor.gray.cgColor
          }
      
    
    
    @IBAction func onClick(_ sender: UIButton) {
        
        let createdClassroomViewController = self.storyboard?.instantiateViewController(identifier: Constants.storyboard.createdClassroomViewController) as? createdClassroomViewController
        self.view.window?.rootViewController = createdClassroomViewController
        self.view.window?.makeKeyAndVisible()
    }
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}

