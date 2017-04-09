//
//  NetworkReachability.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 09/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit
import Alamofire

class NetworkReachability {

    static private let networkReachability = NetworkReachabilityManager()
    
    static func updateMetheoritesWhenInternetComesAlive(in controller: MeteorResultTableViewController, selector: Selector) {
        
        networkReachability?.startListening()
        
        networkReachability?.listener = { status in
            
            switch status {
                
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):

                self.networkReachability?.stopListening()
                controller.perform(selector)
                
            default:
                return
            }
        }
    }
}
