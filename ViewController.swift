//
//  ViewController.swift
//  MyPizza
//
//  Created by YTT on 16/11/26.
//  Copyright © 2016年 YTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField_customerId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField_customerId.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view, typically from a nib.
        
        textField_customerId.delegate = self
        
        assignbackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func get() -> Bool
    {
        //let url = NSURL(string: "http://192.168.0.17/service.php?id="+toPass)
        //let data = NSData(contentsOf: url as! URL)
        
        let url = NSURL(string: "https://synctech.000webhostapp.com/service.php?id="+textField_customerId.text!)
        let data = NSData(contentsOf: url as! URL)
        if(data != nil)
        {
            if (data?.length != 0)
            {
                return true;
            }
            else
            {
                
                let alert = UIAlertController(title: "Warning", message: "No customer ID found, Please verify.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
        }
        return true
 
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(get()==false)
        {
            let alertController = UIAlertController(title: title, message: "No customer ID found, Please verify.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            if (segue.identifier == "segue_home_customer_details") {
                let svc = segue.destination as! DetailViewController;
                
                svc.toPass = textField_customerId.text
                print(textField_customerId.text)
                
            }
            
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }


}

