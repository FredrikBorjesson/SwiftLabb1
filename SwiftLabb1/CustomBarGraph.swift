//
//  CustomBarGraph.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-03-05.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import Foundation
import GraphKit

class CustomBarGraph: NSObject, GKBarGraphDataSource{

    var food = Food()
    
    init(food : Food){
     self.food = food
    }
    
    public func numberOfBars() -> Int{
        return 3
    }
    
    public func valueForBar(at index: Int) -> NSNumber!{
        if index == 0{
            return NSNumber(integerLiteral: food.protein)
        }else if index == 1{
            return NSNumber(integerLiteral: food.fat)
        }else{
            return NSNumber(integerLiteral: food.carbohydrates)
        }
    }
    
    public func colorForBar(at index: Int) -> UIColor!{
        return UIColor.blue
    }
    
    public func colorForBarBackground(at index: Int) -> UIColor!{
        return UIColor(white: 1, alpha: 0.5)
    }
    
    public func animationDurationForBar(at index: Int) -> CFTimeInterval{
        return 1.0
    }
    
    
    public func titleForBar(at index: Int) -> String!{
        if index == 0{
            return "\(food.protein)%"
        }else if index == 1{
            return "\(food.fat)%"
        }else{
            return "\(food.carbohydrates)%"
        }
    }




}
