//
//  DetailViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/26.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var toPass:String!
    
    @IBOutlet weak var label_id: UILabel!
    @IBOutlet weak var label_telephone: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_postcode: UILabel!
    @IBOutlet weak var label_points: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        get()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get()
    {
        let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass)
        let data = NSData(contentsOf: url as! URL)
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
        
        
        
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "segue_add_new_sale") {
            var svc = segue.destination as! NewSaleViewController;
            
            svc.toPass_id = label_id.text
            svc.toPass_points = label_points.text
            
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

}
