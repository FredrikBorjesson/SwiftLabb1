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

    var food1 = Food()
    var food2 = Food()
    let barColors = [UIColor.blue, UIColor.green]
    var valueArray : [Int] = []
    
    init(food1 : Food, food2: Food){
        valueArray = [food1.protein, food2.protein, food1.fat, food2.fat, food1.carbohydrates, food2.carbohydrates]
    }
    
    public func numberOfBars() -> Int{
        return 6
    }
    
    public func valueForBar(at index: Int) -> NSNumber!{
        return NSNumber(integerLiteral: valueArray[index])
    }
    
    public func colorForBar(at index: Int) -> UIColor!{
        return barColors[index % 2]
    }
    
    public func colorForBarBackground(at index: Int) -> UIColor!{
        return UIColor(white: 1, alpha: 0.5)
    }
    
    public func animationDurationForBar(at index: Int) -> CFTimeInterval{
        return 1.0
    }
    
    
    public func titleForBar(at index: Int) -> String!{
      
            return "\(valueArray[index])%"
    }




}
