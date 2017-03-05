//
//  InformationViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-21.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit
import GraphKit

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GKBarGraphDataSource {
    
    var pressedFood : Food?
    var searchedString : String?
    
    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var healthyValue: UILabel!
    @IBOutlet weak var graphView: UIView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var healthPoints1: UIImageView!
    @IBOutlet weak var healthPoints2: UIImageView!
    @IBOutlet weak var healthPoints3: UIImageView!
    @IBOutlet weak var healthPoints4: UIImageView!
    @IBOutlet weak var healthPoints5: UIImageView!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.layer.cornerRadius = 5
        pictureButton.layer.cornerRadius = 5
        setLabels()
        if let image = UIImage(contentsOfFile: imagePath){
            setImage(image: image)
            
        } else {
            pictureLabel.isHidden = false
            foodImage.alpha = 0.7
        }
        
        animateHealthPoints()
        self.title = "Info"
        
        let graph = GKBarGraph(frame: CGRect(x: 0, y: 0, width: graphView.frame.width, height: graphView.frame.height))
        graph.barHeight = graphView.frame.height * 0.75
        graph.dataSource = self
        graphView.addSubview(graph)
        graph.barWidth = graph.frame.width / CGFloat(self.numberOfBars() + 1)
        graph.draw()
    }
    
    
    @IBAction func addFavotrit(_ sender: UIButton) {
        if var array = UserDefaults.standard.object(forKey: "favorites") as? [Int]{
            if array.contains(pressedFood!.number){
                print("Finns redan") // Lägg till Toast
            } else{
                array.append(pressedFood!.number)
                
                UserDefaults.standard.set(array, forKey: "favorites")
                print("\(pressedFood!.number) sparas andra gången")
            }
        } else {
            let newArray = [pressedFood!.number]
            UserDefaults.standard.set(newArray, forKey: "favorites")
            print("\(pressedFood!.number) spara första gången")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueSender = segue.destination as! TableViewController
        segueSender.foodToCompare = pressedFood!
        segueSender.searchedString = searchedString
        segueSender.compareMode = true
     }*/
    
    func setLabels(){
        name.text = pressedFood!.name
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            picker.sourceType = .savedPhotosAlbum
        } else{
            print("Did not take picture")
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        setImage(image: image)
        if let data = UIImagePNGRepresentation(image){
            do{
                let url = URL(fileURLWithPath: imagePath)
                try data.write(to: url)
                NSLog("Done writing image to \(imagePath)")
            } catch{
                NSLog("Could not write image to url")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setImage(image: UIImage){
        foodImage.image = image
        foodImage.alpha = 1
        foodImage.backgroundColor = UIColor.clear
        pictureLabel.isHidden = true
        
    }
    
    var imagePath : String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first{
            return documentsDirectory.appending("/\(pressedFood!.number).png")
        } else {
            fatalError("No directory found")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func animateHealthPoints(){
        print("Healthy value: \(pressedFood!.healthyValue)")
        var hValue : Int = 0
        if let value = pressedFood?.healthyValue{
            hValue = value
        }
        
        
        
        UIView.animate(withDuration: 2, animations: {
            self.healthPoints1.image = #imageLiteral(resourceName: "apple-value")
            self.healthPoints1.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.healthPoints1.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        if hValue > 5{
            UIView.animate(withDuration: 2, animations: {
                self.healthPoints2.image = #imageLiteral(resourceName: "apple-value")
                self.healthPoints2.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.healthPoints2.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        if hValue > 8{
            UIView.animate(withDuration: 2, animations: {
                self.healthPoints3.image = #imageLiteral(resourceName: "apple-value")
                self.healthPoints3.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.healthPoints3.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        if hValue > 12{
            UIView.animate(withDuration: 2, animations: {
                self.healthPoints4.image = #imageLiteral(resourceName: "apple-value")
                self.healthPoints4.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.healthPoints4.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        if hValue > 15{
            UIView.animate(withDuration: 2, animations: {
                self.healthPoints5.image = #imageLiteral(resourceName: "apple-value")
                self.healthPoints5.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.healthPoints5.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
    }
    
    
    func numberOfBars() -> Int{
        return 3
    }
    
    func valueForBar(at index: Int) -> NSNumber!{
        if index == 0{
            return NSNumber(integerLiteral: pressedFood!.protein)
        }else if index == 1{
            return NSNumber(integerLiteral: pressedFood!.fat)
        }else{
            return NSNumber(integerLiteral: pressedFood!.carbohydrates)
        }
    }
    
    func colorForBar(at index: Int) -> UIColor!{
        return UIColor.blue
    }
    
    func colorForBarBackground(at index: Int) -> UIColor!{
        return UIColor(white: 1, alpha: 0.5)
    }
    
    func animationDurationForBar(at index: Int) -> CFTimeInterval{
        return 1.0
    }
    
    func titleForBar(at index: Int) -> String!{
        if index == 0{
            return "\(pressedFood!.protein)%"
        }else if index == 1{
            return "\(pressedFood!.fat)%"
        }else{
            return "\(pressedFood!.carbohydrates)%"
        }
    }
}



