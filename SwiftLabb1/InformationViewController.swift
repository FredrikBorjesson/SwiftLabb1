//
//  InformationViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-21.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    var pressedCellNumber : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(pressedCellNumber)"
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
