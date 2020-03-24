//
//  homeViewController.swift
//  HAK_V1
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class homeViewController: BaseViewController, UICollectionViewDelegate ,UICollectionViewDataSource {
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
        if UserDefaults.standard.bool(forKey: "IsUserSignedIn") == false {            
// go login
        
            print("in home ")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "signInViewController") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
          
            
            
        }else{
        super.viewDidLoad()
        self.title = "الصفحة الرئيسية"
        self.getData()
        addSlideMenuButton()
       collectionView.delegate = self
       collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 40,left: 40,bottom: 15,right: 40 )
        let width = self.calculateWith()
        layout.itemSize = CGSize(width: 140, height: 180)
        collectionView?.setCollectionViewLayout(layout, animated: true) //was false
        }}
    
        func getData(){
            if Auth.auth().currentUser != nil {
                let user = Auth.auth().currentUser
                userId = user!.uid }
            // db ref
            let ref = Database.database().reference().child("sciences").child(userId)
              // query + set data status != "removed"
                    ref.observe(.value) { snapshot in
                        
                        if snapshot.exists() == false {
                            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                            label.center = self.view.center
                            label.textAlignment = .center
                            label.text = "لا يوجد غرف دراسية مضافة"
                            self.view.addSubview(label)
                        }else{
                            self.data.removeAll()
                            self.dataImg.removeAll()
                            self.cellId.removeAll()
                        for case let child as DataSnapshot in snapshot.children {
                        if let value = child.value as? [String:AnyObject]{
                            if (value["status"] as! String).elementsEqual("opened"){
                        self.data.append(value["name"] as! String)
                        self.dataImg.append(UIImage(named:"microscope")!)
                        self.cellId.append(value["id"] as! String)}
                            }
                        } // end for
                        }// end else
                        DispatchQueue.main.async{
                        self.collectionView.reloadData()}
                        }// end ret
           }// end method getData
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.className.text = data[indexPath.item]
        cell.image.image = dataImg[indexPath.item]
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 20
         cell.layer.masksToBounds = true
        return cell
    }
  
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              let cell = collectionView.cellForItem(at: indexPath)
                cell?.layer.borderColor = UIColor.white.cgColor
                          cell?.layer.borderWidth = 1
                        cell?.layer.borderColor = UIColor.gray.cgColor
            self.selectedCell = cellId[indexPath.item]
            performSegue(withIdentifier: "singleClass", sender: self)
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? singleClassViewController {
       // vc.modalPresentationStyle = .fullScreen
        vc.classId = self.selectedCell
            vc.userId = self.userId
            
        }
       
        
    }
    
          func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
              let cell = collectionView.cellForItem(at: indexPath)
              cell?.layer.borderColor = UIColor.white.cgColor
              cell?.layer.borderWidth = 0.5
            cell?.layer.borderColor = UIColor.gray.cgColor
            
          }
      
    
    
   
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
    
}

