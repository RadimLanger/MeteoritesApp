//
//  MeteoriteCollectionSorter.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 09/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

class MeteoriteCollectionSorter {

    enum SortOptions {
        case mass
        case year
    }
    
    static func sortData(meteoritesDataCollection: [Meteorite], option: SortOptions) -> [Meteorite] {
        
        if option == .mass {
             return meteoritesDataCollection.sorted(by: { $0.mass > $1.mass } )
        } else {
            return meteoritesDataCollection.sorted(by: { $0.impactDate.compare($1.impactDate) == .orderedAscending })
        }
    }

    
}
