//
//  Food.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-03-04.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import Foundation

class Food{
    var name : String?
    var number : Int = 0
    var energy : Int = 0
    var protein : Int = 0
    var fat : Int = 0
    var carbohydrates : Int = 0
    var foodValue = 0
    
    
    var retrivedData = false
    
    var healthyValue : Int? {
        return protein + carbohydrates - fat
    }
    
}
