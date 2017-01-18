//
//  DetailViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/26.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView_1: UITableView!
    var toPass:String!
    
    @IBOutlet weak var label_id: UILabel!
    @IBOutlet weak var label_telephone: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_postcode: UILabel!
    @IBOutlet weak var label_points: UILabel!
    
    
    //for tableview
    var items: [String] = []
    var currentPoints:Int!
    var itemPoints:Int!
    var displayName: String!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var b = get()
        
        if(b == true)
        {
            self.myTableView_1.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
            getredeem()
        }
        else
        {
            //self.navigationController?.popViewControllernanimated;: imated: true)
            //self.dismiss(animated: true, completion: nil);
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FirstView") as! ViewController
            self.present(vc, animated: true, completion: nil)

        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get() -> Bool
    {
        //let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass)
        //let data = NSData(contentsOf: url as! URL)
        
        let url = NSURL(string: "https://synctech.000webhostapp.com/service.php?id="+toPass)
        let data = NSData(contentsOf: url as! URL)
        if(data != nil)
        {
            if (data?.length != 0)
            {
                let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let telephone = values["tel"]
                let id = values["id"]
                let postcode = values["postcode"]
                let email = values["email"]
                let points = values["points"]
                label_id.text = id as! String
                label_telephone.text = telephone as! String
                label_postcode.text = postcode as! String
                label_email.text = email as! String
                label_points.text = points as! String
                
                return true;
            }
            else
            {
                
                let alert = UIAlertController(title: "Warning", message: "No customer ID found, Please verify.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
        }
        return true
        /*
        if (data?.length != 0)
        {
        let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        
        let telephone = values["tel"]
        let id = values["id"]
        let postcode = values["postcode"]
        let email = values["email"]
        let points = values["points"]
        label_id.text = id as! String
        label_telephone.text = telephone as! String
        label_postcode.text = postcode as! String
        label_email.text = email as! String
        label_points.text = points as! String
        
            return true;
        }
        else
        {
            
            let alert = UIAlertController(title: "Warning", message: "No customer ID found, Please verify.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        */
        
        
        
        
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "segue_add_new_sale") {
            var svc = segue.destination as! NewSaleViewController;
            
            svc.toPass_id = label_id.text
            svc.toPass_points = label_points.text
            
        }
        else if (segue.identifier == "segue_detail_edit_customer")
        {
            var svc = segue.destination as! EditCustomerViewController;
            
            svc.toPass_id = label_id.text

            
        }
        else if (segue.identifier == "segue_to_redeem")
        {
            var svc = segue.destination as! MyTableViewController;
            
            svc.toPass_id = label_id.text
            
            
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //following codes are for tableview
    func getredeem()
    {
        //let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass)
        let url = NSURL(string: "https://synctech.000webhostapp.com/service.php?id="+toPass)
        
        let data = NSData(contentsOf: url as! URL)
        
        if(data != nil)
        {
            let values = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            let points = values["points"]
            
            var temp = points as! String
            currentPoints = Int(temp)
            
            var redeem_ids = values["redeem"] as! String
            
            let idArr = redeem_ids.components(separatedBy: "_")
            let count = idArr.count
            items.removeAll()
            for i in 0...count-1
            {
                var redeemId: String = idArr[i]
                //let url_1 = NSURL(string: "http://192.168.0.17/redeemService.php?RedeemId="+redeemId)
                let url_1 = NSURL(string: "https://synctech.000webhostapp.com/redeemService.php?RedeemId="+redeemId)
                
                let data_1 = NSData(contentsOf: url_1 as! URL)
                
                if(data_1 != nil)
                {
                    let values_1 = try! JSONSerialization.jsonObject(with: data_1! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let redeemName = values_1["RedeemName"] as! String
                    let redeemPoints = values_1["RedeemPoints"] as! String
                    displayName = redeemName+"_"+redeemPoints
                    if(redeemPoints != "0")
                    {
                        items.append(displayName)
                    }
                    
                }
                
                
            }
            
            
        }
        
        //myTableView_1.beginUpdates()
        //myTableView_1.endUpdates()
        self.myTableView_1.reloadData()
        
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;//self.items.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count;
    }
    
    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.myTableView_1.dequeueReusableCell(withIdentifier: "MyTableViewCell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        
        //let url = NSURL(string: "http://192.168.0.17/updatePointsService.php?customer_id="+toPass+"&points="+tempStr)
        
        let url = NSURL(string: "https://synctech.000webhostapp.com/updatePointsService.php?customer_id="+toPass+"&points="+tempStr)
        
        
        let data = NSData(contentsOf: url as! URL)
        
 
        label_points.text = tempStr
        
        //self.dismiss(animated: true, completion:{NSLog("Close window")});
        
        //Update redeem items
        let url_1 = NSURL(string: "https://synctech.000webhostapp.com/updatePointsService.php?id="+toPass+"&points="+tempStr)
        let data_1 = NSData(contentsOf: url_1 as! URL)
        getredeem()
        
        

    }
    
    func myCancel()
    {
        print("cancel pressed")
        self.dismiss(animated: true, completion:{NSLog("Close window")});
    }


}
