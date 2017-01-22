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
        
        self.textField_customerId.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view, typically from a nib.
        
        assignbackground()
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
    
    func assignbackground(){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }


}

