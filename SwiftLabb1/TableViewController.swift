//
//  TableViewController.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-17.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var foodArray : [Food] = []
    var searchedString : String?
    var searchedSelected = true
    var favoritesArray : [Int] = []
    var favoriteFoodArray : [Food] = []
    var compareMode = false
    var foodToCompare = Food()
    
    @IBOutlet weak var compareButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "food-search"))
        imageView.alpha = 0.3
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        
        getSeacrhedResults(searchedWord: searchedString!){
            self.foodArray = $0
            self.tableView.reloadData()
        }
        
        if let maybeFavoritesArray = UserDefaults.standard.object(forKey: "favorites") as? [Int]{
            favoritesArray = maybeFavoritesArray
        }
        
        for number in self.favoritesArray{
            let tempFood = Food()
            tempFood.number = number
            setupFoodObject(food: tempFood){
                self.favoriteFoodArray.append($0)
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func favoriteOrNot(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            searchedSelected = true
        } else {
            searchedSelected = false
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedSelected{
            return foodArray.count
        } else {
            return self.favoritesArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as!
        CustomTableViewCell
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0)
        if searchedSelected{
            cell.name.text = foodArray[indexPath.row].name
            if foodArray[indexPath.row].retrivedData{
                cell.value.text = "kcal: \(foodArray[indexPath.row].energy)"
                print("Värde finns")
            } else {
                self.foodArray[indexPath.row].retrivedData = true
                setupFoodObject(food: foodArray[indexPath.row]){
                    print("Nummer: \(self.foodArray[indexPath.row].number)")
                    self.foodArray[indexPath.row] = $0
                    print("värde hämtas")
                    DispatchQueue.main.async {
                        cell.value.text = "kcal: \(self.foodArray[indexPath.row].energy)"
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            cell.name.text = favoriteFoodArray[indexPath.row].name
            cell.value.text = "kcal: \(favoriteFoodArray[indexPath.row].energy)"
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if compareMode == false{
            self.performSegue(withIdentifier: "info", sender: self)
        } else {
            if self.tableView.indexPathsForSelectedRows?.count == 2{
                self.performSegue(withIdentifier: "compare", sender: self)
            }
        }
        
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            let segueSender = segue.destination as! InformationViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                segueSender.pressedFood = foodArray[indexPath.row]
                segueSender.searchedString = searchedString
            }
        } else{
            let segueSender = segue.destination as! CompareViewController
            if let indexPaths = tableView.indexPathsForSelectedRows{
                segueSender.food1 = foodArray[indexPaths[0].row]
                segueSender.food2 = foodArray[indexPaths[1].row]
            }
        }
    }
    
    @IBAction func compareButtonPressed(_ sender: Any) {
        if self.compareMode == false{
            self.tableView.allowsMultipleSelection = true
            compareMode = true
        } else {
            self.tableView.allowsMultipleSelection = false
            compareMode = false
        }
    }
    
    
}


class CustomTableViewCell : UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    var number : Float = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
