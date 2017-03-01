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
    var searchedResult : [[String: Any]] = []
    var searchedSelected = true
    var favoritesArray : [Int] = []
    var favoriteNameArray : [String] = []
    var favoriteEnergyArray : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSeacrhedResults(searchedWord: searchedString!){
            self.searchedResult = $0
            self.searchToFoodObjects()
            self.tableView.reloadData()
        }
        
        
        if let maybeFavoritesArray = UserDefaults.standard.object(forKey: "favorites") as? [Int]{
            favoritesArray = maybeFavoritesArray
        }
        
        for number in self.favoritesArray{
            getCertainFoodAsJson(foodNumber: (number)){
                if let name = $0["name"] as? String{
                    self.favoriteNameArray.append(name)
                }
            }
            getCertainEnergyvalue(foodNumber: number){
                self.favoriteEnergyArray.append($0)
            }

        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("i viewwillappear")
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
        // Dispose of any resources that can be recreated.
        
    }
    
    func setJsonData(jsonData : [[String: Any]]){
        searchedResult = jsonData
        tableView.reloadData()
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
        
        if searchedSelected{
            cell.name.text = foodArray[indexPath.row].name
            if foodArray[indexPath.row].retrivedData{
                cell.value.text = "\(foodArray[indexPath.row].energy)"
                print("Värde finns")
            } else {
                setupFoodObject(food: foodArray[indexPath.row]){
                    self.foodArray[indexPath.row] = $0
                    cell.value.text = "\(self.foodArray[indexPath.row].energy)"
                    print("värde hämtas")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            cell.name.text = favoriteNameArray[indexPath.row]
            cell.value.text = "Energi: \(favoriteEnergyArray[indexPath.row])"
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueSender = segue.destination as! InformationViewController
        if let indexPath = tableView.indexPathForSelectedRow{
                segueSender.pressedFood = foodArray[indexPath.row]
        }
        
        
     }
    
    func searchToFoodObjects(){
        for s in searchedResult{
            let tempFood = Food()
            tempFood.name = s["name"] as! String
            tempFood.number = s["number"] as! Int
            foodArray.append(tempFood)
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
