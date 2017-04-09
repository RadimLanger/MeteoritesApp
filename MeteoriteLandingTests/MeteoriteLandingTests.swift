//
//  MeteoriteLandingTests.swift
//  MeteoriteLandingTests
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import XCTest
@testable import MeteoriteLanding
import Alamofire
import SwiftyJSON

class MeteoriteLandingTests: XCTestCase {
    
    let apiHandler = APIHandler()
    let APIURLString = "https://data.nasa.gov/resource/y77d-th95.json?$where=year >= '2011-01-01T00:00:00'"
    let headers = ["X-App-Token": "glEDYc5VHKpULc6er0kZlvZIv"]


    func test_validObjectResponse_noNetworkError_ValidMeteoriteCollection() {
        
        apiHandler.getMeteoritesData { meteoriteCollection, error in
            
            XCTAssertNil(error)
            
            XCTAssertNotNil(meteoriteCollection)

            XCTAssertNotNil(meteoriteCollection?.count)
        }
    }
    
    func test_ParsingJSON() {

        let URL = APIURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        Alamofire.request(URL, method: .get, parameters: [:], headers: headers).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                let json = JSON(jsonResponse)
                
                for (String: _, JSON: subJSON) in json {
                    XCTAssertNotNil(subJSON["name"].stringValue)
                    XCTAssertNotNil(subJSON["mass"].stringValue)
                    XCTAssertNotNil(subJSON["year"].stringValue)
                    XCTAssertNotNil(subJSON["recclass"].stringValue)
                    XCTAssertNotNil(subJSON["id"].intValue)
                    XCTAssertNotNil(subJSON["fall"].stringValue)
                    XCTAssertNotNil(subJSON["geolocation", "coordinates"][0].doubleValue)
                    XCTAssertNotNil(subJSON["geolocation", "coordinates"][1].doubleValue)
                }
            }

        }

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
