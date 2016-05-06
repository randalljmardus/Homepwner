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
    let itemArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
        
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //remove item from array
        allItems.removeAtIndex(fromIndex)
        
        //insert item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
}



