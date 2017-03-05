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
    @IBOutlet weak var graphView1: UIView!
    @IBOutlet weak var graphView2: UIView!
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        name1.text = food1.name
        name2.text = food2.name
        print("\(graphView1.center.x)")
        let graph1 = GKBarGraph(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height/5))
        let customData1 = CustomBarGraph(food: food1)
        graph1.dataSource = customData1
        graphView1.addSubview(graph1)
        graph1.draw()
        
        let graph2 = GKBarGraph(frame: CGRect(x: view.frame.minX, y: view.frame.minX, width: view.frame.width, height: view.frame.height))
        let customData2 = CustomBarGraph(food: food2)
        graph2.dataSource = customData2
        graphView2.addSubview(graph2)
        graph2.draw()
        
     
    }


    
    

}
