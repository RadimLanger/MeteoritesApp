//
//  APIHandler.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIHandler {

    let APIURLString = "https://data.nasa.gov/resource/y77d-th95.json?$where=year >= '2011-01-01T00:00:00'"
    let headers = ["X-App-Token": "glEDYc5VHKpULc6er0kZlvZIv"]
    
    func getMeteoritesData(_ completionHandler: @escaping ([Meteorite]?, _ error: NSError?) -> Void) {

        let URL = APIURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var meteoritesDataCollection: [Meteorite] = []
        
        Alamofire.request(URL, method: .get, parameters: [:], headers: headers).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                let json = JSON(jsonResponse)
                
                for (String: _, JSON: subJSON) in json {
                    let name = subJSON["name"].stringValue
                    let mass = subJSON["mass"].stringValue
                    let year = subJSON["year"].stringValue
                    let recclass = subJSON["recclass"].stringValue
                    let id = subJSON["id"].intValue
                    let fall = subJSON["fall"].stringValue
                    let longitude = subJSON["geolocation", "coordinates"][0].doubleValue
                    let latitude  = subJSON["geolocation", "coordinates"][1].doubleValue
                    
                    let meteorite = Meteorite(name: name, mass: mass, year: year, recclass: recclass, id: id, fall: fall, longitude: longitude, latitude: latitude)
                    
                    meteoritesDataCollection.append(meteorite)
                }
            }
            
            completionHandler(meteoritesDataCollection, response.result.error as NSError?)
        }
        
    }
}
