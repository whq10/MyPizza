//
//  ViewController.swift
//  MyPizza
//
//  Created by Bruce on 16/11/26.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField_customerId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "segue_home_customer_details") {
            let svc = segue.destination as! DetailViewController;
            
            svc.toPass = textField_customerId.text
            print(textField_customerId.text)
            
        }
    }


}

