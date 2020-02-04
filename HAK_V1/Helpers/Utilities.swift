//
//  Utilities.swift
//  HAK_V1
//
//  Created by Raghad on 10/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import Foundation
import UIKit
class Utilities {


static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}


}
