//
//  TableViewController.swift
//  TableViewController
//
//  Created by daicudu on 11/16/18.
//  Copyright © 2018 daicudu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    @IBOutlet  var nodataView: UIView!
    
    @IBOutlet  var redView: UIView!
    var noData: Bool = true {
        didSet {
            noData ? (tableView.tableFooterView = nodataView) : (tableView.tableFooterView = redView)
        }
    }
    
    
    var numbers = [Int](5...10)
    func sortData() {
        for i in 0..<numbers.count-1 {
            for j in i+1..<numbers.count {
                if numbers[i] > numbers[j] {
                    numbers.swapAt(i, j)
                }
            }

        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sortData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noData = (numbers.count == 0)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     return numbers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(numbers[indexPath.row])
        if numbers[indexPath.row] % 2 == 0 {
            cell.backgroundColor = UIColor.red
            
        }else {
            cell.backgroundColor = UIColor.green
        }
        

        // Configure the cell...

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            numbers.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            noData = (numbers.count == 0)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
             if let indexPath = tableView.indexPathForSelectedRow {
            destination.dataDetail = String(numbers[indexPath.row])
        }
    }
    }
    
    

    
    
    @IBAction func unwind(_ sender : UIStoryboardSegue) {
        if let source = sender.source as? ViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                numbers[indexPath.row] = Int(source.dataDetail!) ?? 0
            }
            else {
                numbers.append(Int(source.dataDetail!) ?? 0)
            }
            sortData()
            
        }
        
        tableView.reloadData()
    }
    
    
    
//    @IBAction func unwind1(for unwindSegue: UIStoryboardSegue) {
////        if let add = unwindSegue.source as? ViewController {
//            numbers.appendInt(dataDetail ?? "") ?? 0
//        }
//    }
//
//
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

