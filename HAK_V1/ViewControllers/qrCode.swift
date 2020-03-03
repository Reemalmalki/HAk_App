//
//  QRcode.swift
//  HAK_V1
//
//  Created by Reem Almalki on 25/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
class qrCode : UIViewController {
    
    
    func uploadImg(uniqueId : String , userId : String , classId : String ) -> UIImage {
    var URL = ""
    let imageName:String = String("\(uniqueId).png")
        let image : UIImage = self.generateQRCode(from: "\(userId)@\(classId)")!
        let ref = Storage.storage().reference().child("sciences").child(userId).child(imageName)
        // 1
        let imageData = image.jpegData(compressionQuality: 0.1)!

        // 2
        ref.putData(imageData, metadata: nil, completion: { (metadata, error) in
            
            // 3
            ref.downloadURL(completion: { (url, error) in
                if error != nil {
                }
                URL = url!.absoluteString
                let databaseRef = Database.database().reference().child("sciences").child(userId).child(classId)
                databaseRef.updateChildValues(["url" : URL ])

            })
        })
      return image
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
    
    
}
