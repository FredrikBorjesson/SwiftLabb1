//
//  CompareViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-03-04.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit
import GraphKit

class CompareViewController: UIViewController{
    
    var food1 = Food()
    var food2 = Food()
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name1.text = food1.name!
        name2.text = food2.name!
        name1.textColor = UIColor.blue
        name2.textColor = UIColor.green
        let graph = GKBarGraph(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height * 0.8))
        graph.barWidth = 15
        graph.barWidth = 10
        let customData1 = CustomBarGraph(food1: food1, food2: food2)
        graph.dataSource = customData1
        view.addSubview(graph)
        graph.draw()
        
     
    }

}
