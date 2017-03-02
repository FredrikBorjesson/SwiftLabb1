//
//  SearchViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-17.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var animator : UIDynamicAnimator!
    var snapText : UISnapBehavior!
    var snapButton : UISnapBehavior!

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchedText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        animateSearchField()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueSender = segue.destination as! TableViewController
        segueSender.searchedString = searchedText.text
        // Pass the selected object to the new view controller.
    }
    
    func animateSearchField(){
        animator = UIDynamicAnimator(referenceView: view)
        snapText = UISnapBehavior(item: searchedText, snapTo: view.center)
        let buttonPoint = CGPoint(x: view.center.x + (searchButton.frame.width * 1.5), y: view.center.y + searchedText.frame.height + 10)
        snapButton = UISnapBehavior(item: searchButton, snapTo:buttonPoint)
        
        snapButton.damping = 0.5
        snapText.damping = 0.5
        animator.addBehavior(snapButton)
        animator.addBehavior(snapText)
        
    }
    

}
