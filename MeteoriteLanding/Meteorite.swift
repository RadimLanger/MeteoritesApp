//
//  Meteorite.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

struct Meteorite {

    private let dateFormatter = DateFormatter()
    
    let name: String
    let mass: String
    let impactDate: Date
    let impactDateString: String
    let recclass: String
    let id: Int
    let fall: String
    let longitude: Double
    let latitude: Double
    
    init(name: String, mass: String, year: String, recclass: String, id: Int, fall: String, longitude: Double, latitude: Double) {

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")

        let impactDate = dateFormatter.date(from: year)!
        
        self.name = name
        self.mass = mass
        self.impactDate = impactDate
        
        dateFormatter.dateFormat = "yyyy"
        
        self.impactDateString =  dateFormatter.string(from: impactDate)
        self.recclass = recclass
        self.id = id
        self.fall = fall
        self.longitude = longitude
        self.latitude = latitude
    }
    
}
