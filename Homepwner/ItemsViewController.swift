//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Randall Mardus on 4/28/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(sender: AnyObject) {
        //create a new item and add it to the store
        let newItem = itemStore.createItem()
    
        //figure out where that item is in the array
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            //insert this new row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        //if you are currently editing mode...
        if editing {
            //change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            //turn off editing mode
            setEditing(false, animated: true)
        }
        
        else {
            //change text of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            //enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        //update the labels for the new preferred text size
        cell.updateLabels()
        
        //set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        //configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //if the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
            
            //remove the item from the store
            self.itemStore.removeItem(item)
            
            //also remove that row from the table view with an animation
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
            ac.addAction(deleteAction)
            
            //present the alert controller
            presentViewController(ac, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        //update the model
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if the triggered segue is the "ShowItem" segue
        if segue.identifier == "ShowItem" {
            
            //figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
            }
        }
    }
}