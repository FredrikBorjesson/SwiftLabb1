//
//  CompareViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-03-04.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit

class CompareViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
