//
//  ItemStore.swift
//  Homepwner
//
//  Created by Randall Mardus on 4/28/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }

}



