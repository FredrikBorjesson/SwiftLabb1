//
//  JSONHelper.swift
//  SwiftLabb1
//
//  Created by Mr X on 2017-02-20.
//  Copyright © 2017 Fredrik Börjesson. All rights reserved.
//

import Foundation

func getSeacrhedResults(searchedWord : String, setData: @escaping ([[String:Any]]) -> Void){
    
    let urlString = "http://www.matapi.se/foodstuff?query=\(searchedWord)&format=json&pretty=1"
    
    if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: safeUrlString) {
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            (maybeData: Data?, response: URLResponse?, error: Error?) in
            
            if let actualData = maybeData {
                let jsonOptions = JSONSerialization.ReadingOptions()
                do {
                    if let recievedData = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String:Any]] {
                        
                        setData(recievedData)
                    } else {
                        NSLog("Failed to cast from json.")
                    }
                }
                catch let parseError {
                    NSLog("Failed to parse json: \(parseError)")
                }
            } else {
                NSLog("No data received.")
            }
        }
        task.resume()
        
    } else {
        NSLog("Failed to create url.")
    }

}

func getCertainFoodAsJson(foodNumber : Int, setData: @escaping ([String:Any]) -> Void){
    
    let urlString = "http://www.matapi.se/foodstuff/\(foodNumber)"
    
    if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: safeUrlString){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            (maybeData: Data?, response: URLResponse?, error: Error?) in
            
            if let actualData = maybeData{
                let jsonOptions = JSONSerialization.ReadingOptions()
                do{
                    if let recievedData = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            setData(recievedData)
                    }
                }
                catch let parseError {
                    NSLog("Failed to parse json: \(parseError)")
                }
            } else {
                NSLog("No data received.")
            }
        }
        task.resume()
        
    } else {
        NSLog("Failed to create url.")
    }
}

func getCertainEnergyvalue(foodNumber : Int, setData: @escaping (Int) -> Void){
    
    let urlString = "http://www.matapi.se/foodstuff/\(foodNumber)"
    
    if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: safeUrlString){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            (maybeData: Data?, response: URLResponse?, error: Error?) in
            
            if let actualData = maybeData{
                let jsonOptions = JSONSerialization.ReadingOptions()
                do{
                    if let recievedData = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                        if let nutritions = recievedData["nutrientValues"] as? [String:Any]{
                            if let energy = nutritions["energyKcal"] as? Float{
                                setData(Int(energy))
                            }
                        }
                        
                    }
                }
                catch let parseError {
                    NSLog("Failed to parse json: \(parseError)")
                }
            } else {
                NSLog("No data received.")
            }
        }
        task.resume()
        
    } else {
        NSLog("Failed to create url.")
    }
}

func setupFoodObject(food : Food, setData : @escaping (Food) -> Void){

    let urlString = "http://www.matapi.se/foodstuff/\(food.number)"
    
    if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: safeUrlString){
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){
            (maybeData: Data?, response: URLResponse?, error: Error?) in
            
            if let actualData = maybeData{
                let jsonOptions = JSONSerialization.ReadingOptions()
                do{
                    if let recievedData = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {

                        if let nutritions = recievedData["nutrientValues"] as? [String:Any]{
                            if let energy = nutritions["energyKcal"] as? Float{
                                food.energy = Int(energy)
                            }
                        }
                        if let nutritions = recievedData["nutrientValues"] as? [String:Any]{
                            if let protein = nutritions["protein"] as? Float{
                                food.protein = Int(protein)
                            }
                        }
                        if let nutritions = recievedData["nutrientValues"] as? [String:Any]{
                            if let fat = nutritions["fat"] as? Float{
                                food.fat = Int(fat)
                            }
                        }
                        if let nutritions = recievedData["nutrientValues"] as? [String:Any]{
                            if let carbohydrates = nutritions["carbohydrates"] as? Float{
                                food.carbohydrates = Int(carbohydrates)
                            }
                        }
                        setData(food)
                    }
                }
                catch let parseError {
                    NSLog("Failed to parse json: \(parseError)")
                }
            } else {
                NSLog("No data received.")
            }
        }
        task.resume()
        
    } else {
        NSLog("Failed to create url.")
    }



}







