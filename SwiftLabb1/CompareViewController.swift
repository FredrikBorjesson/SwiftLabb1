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
        
        let graph1 = GKBarGraph(frame: CGRect(x: 0, y: 0, width: graphView1.frame.width, height: graphView1.frame.height))
        graph1.barHeight = graphView1.frame.height * 0.75
        let g1 = CustomBarGraph(food: food1)
        graph1.dataSource = g1
        graphView1.addSubview(graph1)
        graph1.draw()
        
        /*
        let graph2 = GKBarGraph(frame: CGRect(x: 0, y: 0, width: graphView2.frame.width, height: graphView2.frame.height))
        graph2.dataSource = CustomBarGraph(food: food2)
        graphView2.addSubview(graph2)
        graph2.draw()*/
    }


    
    

}
