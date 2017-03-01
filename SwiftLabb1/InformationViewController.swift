//
//  InformationViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-21.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var pressedFood : Food?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var carbohydrates: UILabel!
    @IBOutlet weak var healthyValue: UILabel!
   
    @IBOutlet weak var healthPoints1: UIImageView!
    @IBOutlet weak var healthPoints2: UIImageView!
    @IBOutlet weak var healthPoints3: UIImageView!
    @IBOutlet weak var healthPoints4: UIImageView!
    @IBOutlet weak var healthPoints5: UIImageView!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pressedFood!.calculateHealthyValue()
        setLabels()
        
        if let image = UIImage(contentsOfFile: imagePath){
            foodImage.image = image
        } else {
            foodImage.image = #imageLiteral(resourceName: "no-image-available")
        }
        
        //pressedFood!.calculateHealthyValue()
        animateHealthPoints()
        
        self.title = "Info"
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setLabels(){
        name.text = pressedFood!.name
        protein.text = "Protein: \(pressedFood!.protein)"
        fat.text = "Fett: \(pressedFood!.fat)"
        carbohydrates.text = "Kolhydrater: \(pressedFood!.carbohydrates)"
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
        foodImage.image = image
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
        UIView.animate(withDuration: 1.5, animations: {
            self.healthPoints1.image = #imageLiteral(resourceName: "Apple-image")
            self.healthPoints1.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            self.healthPoints1.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        if pressedFood!.healthyValue > 5{
            UIView.animate(withDuration: 1.5, animations: {
                self.healthPoints2.image = #imageLiteral(resourceName: "Apple-image")
                self.healthPoints2.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.healthPoints2.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        if pressedFood!.healthyValue > 10{
            UIView.animate(withDuration: 1.5, animations: {
                self.healthPoints3.image = #imageLiteral(resourceName: "Apple-image")
                self.healthPoints3.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.healthPoints3.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        if pressedFood!.healthyValue > 15{
            UIView.animate(withDuration: 1.5, animations: {
                self.healthPoints4.image = #imageLiteral(resourceName: "Apple-image")
                self.healthPoints4.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.healthPoints4.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        if pressedFood!.healthyValue > 20{
            UIView.animate(withDuration: 1.5, animations: {
                self.healthPoints5.image = #imageLiteral(resourceName: "Apple-image")
                self.healthPoints5.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                self.healthPoints5.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }

}

class Food{
    var name : String = ""
    var number : Int = 0
    var energy : Int = 0
    var protein : Int = 0
    var fat : Int = 0
    var carbohydrates : Int = 0
    var foodValue = 0
    
    var retrivedData = false
    
    var healthyValue : Int {
        return protein + carbohydrates - fat
    }
    
}


