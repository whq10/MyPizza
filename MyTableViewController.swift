//
//  MyTableViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/30.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var toPass_id:String!
    @IBOutlet var tableview: UITableView!
    var items: [String] = []
    var currentPoints:Int!
    var itemPoints:Int!
    var displayName: String!
    
    
    func get()
    {
        let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass_id)
        let data = NSData(contentsOf: url as! URL)
        let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        let points = values["points"]
        
        var temp = points as! String
        currentPoints = Int(temp)
        
        var redeem_ids = values["redeem"] as! String
        
        let idArr = redeem_ids.components(separatedBy: "_")
        let count = idArr.count
        for i in 0...count-1
        {
            var redeemId: String = idArr[i]
            let url_1 = NSURL(string: "http://192.168.0.17/redeemService.php?RedeemId="+redeemId)
            let data_1 = NSData(contentsOf: url_1 as! URL)
            
            let values_1 = try! JSONSerialization.jsonObject(with: data_1! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let redeemName = values_1["RedeemName"] as! String
            let redeemPoints = values_1["RedeemPoints"] as! String
            displayName = redeemName+"_"+redeemPoints
            items.append(displayName)
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        get()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;//self.items.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count;
    }
    
    override func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }

   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do here
        print("You selected cell #\(indexPath.row)!")
        displayName = self.items[indexPath.row]

        
        
        // create the alert
        let alert = UIAlertController(title: "Confirmation", message: "Would you like to continue redeeming item selected ?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {action in self.myContinue()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {action in self.myCancel()}))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
   
    func myContinue()
    {
        let tempArr = displayName.components(separatedBy: "_")
        itemPoints = Int(tempArr[1])
        
        var updatedPoints = currentPoints - itemPoints;
        var tempStr = String(updatedPoints)

        let url = NSURL(string: "http://192.168.0.17/updatePointsService.php?customer_id="+toPass_id+"&points="+tempStr)
        let data = NSData(contentsOf: url as! URL)
        
        //let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        
        
        self.dismiss(animated: true, completion:{NSLog("Close window")});
    }
    
    func myCancel()
    {
        print("cancel pressed")
        self.dismiss(animated: true, completion:{NSLog("Close window")});
    }
      /**/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
